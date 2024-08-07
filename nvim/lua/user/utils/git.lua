function StashStaged()
	local stash_name = vim.fn.input("Enter stash name: ")
	if stash_name ~= "" then
		local command = "git stash push --staged --message=" .. vim.fn.shellescape(stash_name)
		vim.fn.system(command)
	else
		print("Stash name cannot be empty.")
	end
end
