return {
  {
    dir = "~/Projects/tome.nvim",
    dependencies = {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    config = function()
      require("tome")
    end
  }
}
