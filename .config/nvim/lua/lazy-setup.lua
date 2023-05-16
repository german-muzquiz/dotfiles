
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false,  			    -- should plugins be lazy-loaded?
  },
  install = {
    missing = true, 		    	    -- install missing plugins on startup. This doesn't increase startup time.
    colorscheme = { "rose-pine" },          -- try to load one of these colorschemes when starting an installation during startup
  },
  checker = {
    enabled = false,			    -- automatically check for plugin updates
    concurrency = nil, 			    -- @type number? set to 1 to check for updates very slowly
    notify = true, 			    -- get a notification when new updates are found
    frequency = 3600, 			    -- check for updates every hour
  },
  change_detection = {
    enabled = true, 			    -- automatically check for config file changes and reload the ui
    notify = true, 			    -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, 		    -- reset the package path to improve startup time
  },
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
})

