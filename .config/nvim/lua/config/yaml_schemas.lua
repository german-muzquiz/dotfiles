local M = {}

M.path = vim.fn.stdpath("data") .. "/projects"

---@type Schema
local default_schema = { name = "none", uri = "none" }

local sync_timeout = 5000

M.get_schema_mappings = function()
  local status_ok, project = pcall(require, "project_nvim.project")
  if not status_ok then
    return {}
  end
  local root = project.get_project_root()
  return M.get_project_mappings(root)
end

-- @param project string
M.get_project_mappings = function(project)
  print("Returning project mappings for " .. tostring(project))
  return {
    ["https://www.schemastore.org/api/json/catalog.json"] = "**/*",
  }
end

M.current_schema = function(bufnr)
  local schema = M.get_jsonschema(bufnr)
  if not schema or not schema.result[1] then
    return default_schema
  end
  return schema.result[1]
end

-- get schema used for {bufnr} from the yamlls attached to it
---@param bufnr number
M.get_jsonschema = function(bufnr)
  return M.request_sync(bufnr, "yaml/get/jsonSchema")
end

-- get all known schemas by the yamlls attached to {bufnr}
---@param bufnr number
M.get_all_jsonschemas = function(bufnr)
  local schemas = M.request_sync(bufnr, "yaml/get/all/jsonSchemas")
  if schemas ~= nil then
    print("No schemas found")
  end
  return schemas
end

-- inform server that client supports JSON Schema selection.
---@param bufnr number
M.set_support_schema_selection = function(bufnr)
  return M.request_sync(bufnr, "yaml/supportSchemaSelection")
end

---@param bufnr number
---@param method string
---@return table | nil
M.request_sync = function(bufnr, method)
  local client = M.get_client(bufnr)

  if client then
    local response, error = client.request_sync(method, { vim.uri_from_bufnr(bufnr) }, sync_timeout, bufnr)

    if error then
      print("bufnr=%d error=%s", bufnr, error)
    end

    if response and response.err then
      print("bufnr=%d error=%s", bufnr, response.err)
    end

    return response
  end
end

---@param bufnr number
M.get_client = function(bufnr)
  return vim.lsp.get_active_clients({ name = "yamlls", bufnr = bufnr })[1]
end

return M
