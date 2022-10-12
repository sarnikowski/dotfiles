local present, cutlass = pcall(require, "cutlass")

if not present then
  return
end

cutlass.setup({cut_key = "m"})
