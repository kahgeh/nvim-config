local nvim_lsp = require('lspconfig')
return {
  root_dir = function(filename, bufnr)
    local isDenoRootDir = nvim_lsp.util.root_pattern("deno.json")(filename)
    if isDenoRootDir then
      return nil
    end
    return nvim_lsp.util.root_pattern("package.json")(filename)
  end,
  single_file_support = false
}
