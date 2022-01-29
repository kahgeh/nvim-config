local util=require("lspconfig/util")
return {
  root_dir=function(fname)
    return (not util.root_pattern 'mod.ts'(fname)) and (util.root_pattern 'tsconfig.json'(fname)
      or util.root_pattern('package.json', 'jsconfig.json', '.git')(fname))
  end
}
