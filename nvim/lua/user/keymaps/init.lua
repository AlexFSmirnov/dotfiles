require("user.keymaps.global")

if vim.g.vscode then
  require("user.keymaps.vscode")
else
  require("user.keymaps.standalone")
end
