local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local ts_locals = require("nvim-treesitter.locals")
local ts_utils = require("nvim-treesitter.ts_utils")
local log = require("luasnip.util.log").new("java-snippets")

return {
  s(
    { trig = "ret", name = "Return", dscr = "Return a value" },
    c(1, {
      sn(nil, {
        t("return "),
        r(1, "return_value", i(1, "ReturnValue")),
        t(";"),
      }),
      t("return;"),
    })
  ),
  s(
    { trig = "impasst", name = "Import assertions" },
    fmt("import static {};", {
      c(1, {
        t("org.assertj.core.api.Assertions.*"),
        t("org.junit.jupiter.api.Assertions.*"),
      }),
    })
  ),
  s(
    { trig = "ateq", name = "Assert Eq" },
    c(1, {
      fmt("assertThat({}).isEqualTo({});", { r(1, "actual", i(1, "actual")), r(2, "expected", i(1, "expected")) }),
      fmt("assertEquals({}, {});", { r(1, "expected", i(1, "expected")), r(2, "actual", i(1, "actual")) }),
    })
  ),
  s(
    { trig = "atneq", name = "Assert Not Eq" },
    c(1, {
      fmt("assertThat({}).isNotEqualTo({});", { r(1, "actual", i(1, "actual")), r(2, "expected", i(1, "expected")) }),
      fmt("assertNotEquals({}, {});", { r(1, "expected", i(1, "expected")), r(2, "actual", i(1, "actual")) }),
    })
  ),
  s({ trig = "afn", name = "Lambda" }, fmt("({}) -> {{ {} }}", { i(1), i(2) })),
}
