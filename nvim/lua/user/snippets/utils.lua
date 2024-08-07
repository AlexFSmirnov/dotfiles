local ls = require("luasnip")
local f = ls.function_node

local M = {};

-- replicate an insert node
M.c = function(
  parent -- which node to replicate
)
  return f(
    function(args)
      return args[1][1]
    end,
    { parent }
  )
end

-- convert PascalCase to dash-case
local function pascal_to_dash(str)
  return str:gsub('(%u)', '-%1'):lower():gsub('^-', '')
end

-- replicate an insert node and convert to dash-case
M.c_d = function(
  parent -- which node to replicate
)
  return f(
    function(args)
      local original = args[1][1]
      return pascal_to_dash(original)
    end,
    { parent }
  )
end

-- convert PascalCase to camelCase
local function pascal_to_camel_case(str)
  return str:sub(1, 1):lower() .. str:sub(2)
end

-- replicate an insert node and convert to camelCase
M.c_c = function(
  parent -- which node to replicate
)
  return f(
    function(args)
      local original = args[1][1]
      return pascal_to_camel_case(original)
    end,
    { parent }
  )
end

return M;
