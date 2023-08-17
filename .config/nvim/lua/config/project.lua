local M = {
    has_venv = false
}

M.detect_venv = function()
    local venv_path = ''
    if io.open(vim.fn.getcwd() .. '/venv/bin/python', "r") ~= nil then
        venv_path = vim.fn.getcwd() .. '/venv/bin/python'
    elseif io.open(vim.fn.getcwd() .. '/.venv/bin/python', "r") ~= nil then
        venv_path = vim.fn.getcwd() .. '/.venv/bin/python'
    end
    if venv_path == '' then
        M.has_venv = false
        return nil
    end
    M.has_venv = true
    return venv_path
end

return M
