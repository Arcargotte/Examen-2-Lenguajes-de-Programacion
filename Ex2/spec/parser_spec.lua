-- spec/parser_spec.lua
local luaunit = require("luaunit") 
require("parser")

describe("Pruebas de parser", function()

  it("debería parsear correctamente en notación PRE", function()
    local resultado = PRE_Parser("+*+3457")
    -- assert.is_truthy(resultado)
    assert.is_equal(resultado, 42)
  end)

    -- Pruebas PRE_Parser
  it("debería parsear correctamente una suma en notación PRE", function()
    local resultado = PRE_Parser("+34")
    assert.is_equal(resultado, 7)
  end)

  it("debería parsear correctamente en notación PRE", function()
    local resultado = PRE_Parser("*+34+21")
    -- assert.is_truthy(resultado)
    assert.is_equal(resultado, 21)
  end)

  it("debería manejar correctamente una resta en notación PRE", function()
    local resultado = PRE_Parser("-93")
    assert.is_equal(resultado, 6)
  end)

  it("debería manejar correctamente una división en notación PRE", function()
    local resultado = PRE_Parser("/84")
    assert.is_equal(resultado, 2)
  end)

  -- Pruebas POST_Parser
  it("debería parsear correctamente una suma en notación POST", function()
    Stack = {}
    local resultado = POST_Parser("34+")
    assert.is_equal(resultado, 7)
  end)

  it("debería parsear correctamente una expresión compleja en notación POST", function()
    Stack = {}
    local resultado = POST_Parser("34+12+*")
    -- ((3 + 4) * (1 + 2)) = 21
    assert.is_equal(resultado, 21)
  end)

  it("debería manejar correctamente una resta en notación POST", function()
    Stack = {}
    local resultado = POST_Parser("93-")
    assert.is_equal(resultado, 6)
  end)

  it("debería manejar correctamente una división en notación POST", function()
    Stack = {}
    local resultado = POST_Parser("84/")
    assert.is_equal(resultado, 2)
  end)

  -- Pruebas PRE_Mostrar
  it("debería mostrar correctamente una expresión PRE", function()
    local resultado = PRE_Mostrar("/-34+21", "$")
    assert.is_equal(resultado, "(3 - 4) / (2 + 1)")
  end)

  -- Pruebas POST_Mostrar
  it("debería mostrar correctamente una expresión POST", function()
    Stack = {}
    local resultado = POST_Mostrar("34+12+*", "$")
    assert.is_equal(resultado, "(3 + 4) * (1 + 2)")
  end)

end)
