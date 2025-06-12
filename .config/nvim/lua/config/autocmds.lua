-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for shell scripts
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "sh" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Use the skelton files for newly created files
local skeltons = {
  { "*.html", "~/.config/nvim/skel/skel.html" },
  { "*.c",    "~/.config/nvim/skel/skel.c"    },
  { "*.rs",   "~/.config/nvim/skel/skel.rs"   },
  { "*.css",  "~/.config/nvim/skel/skel.css"  },
  { "*.scss", "~/.config/nvim/skel/skel.scss" },
  { "*.py",   "~/.config/nvim/skel/skel.py"   },
  { "*.rb",   "~/.config/nvim/skel/skel.rb"   },
  { "*.tex",  "~/.config/nvim/skel/skel.tex"  },
}

local skel_group = vim.api.nvim_create_augroup(
  "SkeltonAu",
  { clear = true }
)

for _, value in pairs(skeltons) do
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = skel_group,
    pattern = value[1],
    command = "0r "..value[2],
  })
end

-- Insert timestamp after "Last Modified: Thu, 12 Jun 2025 14:41:45 +0900
local function LastModified()
  if vim.bo.modified then
    local save_cursor = vim.fn.getpos(".")
    local n = math.min(200, vim.fn.line("$"))
    local pattern = [[\%(.\{,10}Last [Mm]odified: \)\zs.*]]
    local replacement = os.date("%a, %d %b %Y %H:%M:%S %z")

    vim.cmd(string.format("keepjumps silent! 1,%ds#%s#%s#e", n, pattern, replacement))
    vim.fn.histdel("search", -1)
    vim.fn.setpos(".", save_cursor)
  end
end

local ts_group = vim.api.nvim_create_augroup(
  "TimestampAu",
  { clear = true }
)

vim.api.nvim_create_autocmd("BufWritePre", {
  group = ts_group,
  pattern = "*",
  callback = LastModified,
})
