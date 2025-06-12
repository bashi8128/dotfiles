return {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
        "theHamsta/nvim-dap-virtual-text",
        {
            "mfussenegger/nvim-dap",
        }
    },
    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup()
        require('dap-go').setup()
        require('dapui').setup()
        require("nvim-dap-virtual-text").setup()
    end
}
