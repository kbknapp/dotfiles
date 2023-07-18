require('tokyonight').setup({
    transparent = true
})

function ColorMyPencils(color) 
	color = color or "tokyonight-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()
