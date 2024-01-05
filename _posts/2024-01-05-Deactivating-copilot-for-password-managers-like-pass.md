---
layout: post
title: Deactivating copilot for password managers like pass
categories:
- blog
- copilot 
-tinfoil 
-security 
-nvim
generated on: 2024-01-05
---

If you're using [copilot](https://github.com/copilot) and by luck also use [pass](https://www.passwordstore.org/) to manage
your passwords, you will find that the default configuration, or rather the configuration where you want copilot enabled
everywhere, basically creates a risk for your precious passwords... As Copilot will be enabled by default, on text files.

![My dataaa!](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWZ5aXozcnJvMmRmZ2xra2trY3M4c2Nub2lzbjh4dXIwdHVjZDA2ZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/G1ifnX4d5tYFACktp9/giphy.gif)

So here's the snippet I use:

```
-- initialize copilot
local copilot = {
	"zbirenbaum/copilot.lua",
	"ofseed/copilot-status.nvim",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		filetypes = {
			sh = function()
				if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
					-- disable for .env files
					return false
				end
				return true
			end,
			text = function()
				if
					vim.has_key(vim.environ(), "GIT_CEILING_DIRECTORIES") or vim.has_key(vim.environ(), "PASS_VERSION")
				then
					-- disable for .env files
					return false
				end
				return true
			end,
		},
	},
}
```

I should eventually add this too to my dotfiles... Once I have the time to do so.

![My dotfiles would be here, if I updated them](/assets/images/if-i-had-dotfiles.jpg)

