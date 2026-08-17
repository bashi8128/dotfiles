-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local silent = { silent = true }

-- 
map("n", "j", "gj", { desc = "Down (display line)" })
map("n", "k", "gk", { desc = "Up   (display line)" })
map("n", "J", "}",  { desc = "Next paragraph" })
map("n", "K", "{",  { desc = "Prev paragraph" })
map("n", "<leader>mJ", "J", { desc = "Join lines (default J)" })

map("n", "<leader>mq", ":q!<CR>",  { silent = true, desc = "Force quit" })
map("n", "<leader>mQ", ":wq<CR>",  { silent = true, desc = "Write & quit" })
map("n", "<leader>mZ", ":wq!<CR>", { silent = true, desc = "Force write & quit" })
map("n", "<leader>ms", ":w<CR>",   { silent = true, desc = "Save" })

map("n", "<leader>mw", "<C-w>w", { silent = true })
map("n", "<leader>ml", "<C-w>l", { silent = true })
map("n", "<leader>mh", "<C-w>h", { silent = true })
map("n", "<leader>mk", "<C-w>k", { silent = true })
map("n", "<leader>mj", "<C-w>j", { silent = true })

map("n", "<leader>mb", "<cmd>enew<CR>",     { desc = "New empty buffer" })
map("n", "<leader>m]", "<cmd>bnext<CR>",    { desc = "Next buffer" })
map("n", "<leader>m[", "<cmd>bprevious<CR>",{ desc = "Prev buffer" })
map("n", "<leader>md", "<cmd>bdelete<CR>",  { desc = "Delete buffer", silent = true })
