function RemoveWhitespaces(str)
    return string.gsub(str, "%s+", "")
end

function PRE_Parser (expression) 

    expression = RemoveWhitespaces(expression)

    if (#expression == 1) then
        return tonumber(string.sub(expression, 1, 1))
    end

    if (string.sub(expression, 1, 1) == '+') then
        return PRE_Parser(string.sub(expression, 2, #expression - 1)) + tonumber(string.sub(expression, #expression, #expression))
    elseif (string.sub(expression, 1, 1) == '*') then 
        return PRE_Parser(string.sub(expression, 2, #expression - 1)) * tonumber(string.sub(expression, #expression, #expression))
    elseif (string.sub(expression, 1, 1) == '-') then 
        return PRE_Parser(string.sub(expression, 2, #expression - 1)) - tonumber(string.sub(expression, #expression, #expression))
    elseif (string.sub(expression, 1, 1) == '/') then 
        return PRE_Parser(string.sub(expression, 2, #expression - 1)) / tonumber(string.sub(expression, #expression, #expression))
    end

end

Stack = {}

function Push(stack, value)
    stack[#stack + 1] = value
end

function Pop(stack)
    return table.remove(stack)
end

function Top(stack)
    return stack[#stack]
end

function PrintStack(stack)

    if (#stack == 0) then
        print("Stack vacio!")
    end
    for i = 1, #stack do
        io.write(stack[i])
        io.write(" ")
    end
    io.write("\n")
end

function POST_Parser (expression) 

    expression = RemoveWhitespaces(expression)

    if (#expression == 0) then
        return Top(Stack)
    end

    Push(Stack, string.sub(expression, 1, 1))
    if (Top(Stack) == "+") then
        Pop(Stack)
        Push(Stack,  tonumber(Pop(Stack)) + tonumber(Pop(Stack)))
        return POST_Parser (string.sub(expression, 2, #expression))
    elseif (Top(Stack) == "*") then
        Pop(Stack)
        Push(Stack, tonumber(Pop(Stack)) * tonumber(Pop(Stack)))
        return POST_Parser (string.sub(expression, 2, #expression))
    elseif (Top(Stack) == "-") then
        Pop(Stack)
        Push(Stack, -(tonumber(Pop(Stack))) + tonumber(Pop(Stack)))
        return POST_Parser (string.sub(expression, 2, #expression))
    elseif (Top(Stack) == "/") then
        Pop(Stack)
        Push(Stack, tonumber(Pop(Stack)) / tonumber(Pop(Stack)))
        return POST_Parser (string.sub(expression, 2, #expression))
    else 
        return POST_Parser (string.sub(expression, 2, #expression))
    end
end

PrecedenteTable = {
    ["$"] = 0,
    ["+"] = 1,
    ["-"] = 1,
    ["*"] = 2,
    ["/"] = 2
}

function PRE_Mostrar(expression, lastOperation)

    expression = RemoveWhitespaces(expression)

    if (#expression == 1) then
        return string.sub(expression, 1, 1)
    end

    if (string.sub(expression, 1, 1) == '+' and PrecedenteTable[lastOperation] > PrecedenteTable["+"]) then
        return "(" .. PRE_Mostrar(string.sub(expression, 2, #expression - 1), "+") .. " + " .. string.sub(expression, #expression, #expression) .. ")"

    elseif (string.sub(expression, 1, 1) == '+' and PrecedenteTable[lastOperation] <= PrecedenteTable["+"]) then
        return PRE_Mostrar(string.sub(expression, 2, #expression - 1), "+") .. " + " .. string.sub(expression, #expression, #expression)

    elseif (string.sub(expression, 1, 1) == '-' and PrecedenteTable[lastOperation] > PrecedenteTable["-"]) then
        return "(" .. PRE_Mostrar(string.sub(expression, 2, #expression - 1), "-") .. " - " .. string.sub(expression, #expression, #expression) .. ")"

    elseif (string.sub(expression, 1, 1) == '-' and PrecedenteTable[lastOperation] <= PrecedenteTable["-"]) then
        return PRE_Mostrar(string.sub(expression, 2, #expression - 1), "-") .. " - " .. string.sub(expression, #expression, #expression)

    elseif (string.sub(expression, 1, 1) == '*' and PrecedenteTable[lastOperation] > PrecedenteTable["*"]) then
        return "(" .. PRE_Mostrar(string.sub(expression, 2, #expression - 1), "*") .. " * " .. string.sub(expression, #expression, #expression) .. ")"

    elseif (string.sub(expression, 1, 1) == '*' and PrecedenteTable[lastOperation] <= PrecedenteTable["*"]) then
        return PRE_Mostrar(string.sub(expression, 2, #expression - 1), "*") .. " * " .. string.sub(expression, #expression, #expression)

    elseif (string.sub(expression, 1, 1) == '/' and PrecedenteTable[lastOperation] > PrecedenteTable["/"]) then
        return "(" .. PRE_Mostrar(string.sub(expression, 2, #expression - 1), "/") .. " / " .. string.sub(expression, #expression, #expression) .. ")"

    elseif (string.sub(expression, 1, 1) == '/' and PrecedenteTable[lastOperation] <= PrecedenteTable["/"]) then
        return PRE_Mostrar(string.sub(expression, 2, #expression - 1), "/") .. " / " .. string.sub(expression, #expression, #expression)
    end
    
end

function POST_Mostrar(expression, lastOperation)

    expression = RemoveWhitespaces(expression)

    if (#expression == 0) then
        return Top(Stack)
    end

    Push(Stack, string.sub(expression, 1, 1))

    if (Top(Stack) == "+" and PrecedenteTable[lastOperation] > PrecedenteTable["+"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), "+")
    
    elseif (Top(Stack) == "+" and PrecedenteTable[lastOperation] <= PrecedenteTable["+"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, "(" .. left .. " " .. operator .. " " .. right .. ")")
        return POST_Mostrar(string.sub(expression, 2, #expression), "+")
    
    elseif (Top(Stack) == "-" and PrecedenteTable[lastOperation] > PrecedenteTable["-"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), "-")

    elseif (Top(Stack) == "-" and PrecedenteTable[lastOperation] <= PrecedenteTable["-"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, "(" .. left .. " " .. operator .. " " .. right .. ")")
        return POST_Mostrar(string.sub(expression, 2, #expression), "-")
    
    elseif (Top(Stack) == "*" and PrecedenteTable[lastOperation] <= PrecedenteTable["*"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), "*")

    elseif (Top(Stack) == "/" and PrecedenteTable[lastOperation] <= PrecedenteTable["/"]) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), "/")
    end

    return POST_Mostrar(string.sub(expression, 2, #expression), lastOperation)
end

function Menu()
    while true do
        io.write("\nEscribe una opcion (EVAL, MOSTRAR, SALIR): ")
        local input = io.read()

        local opcion, modo, expr = string.match(input, "(%S+)%s*(%S*)%s*(.*)")
        print(opcion)
        if opcion == "EVAL" then
            if modo == "PRE" then
                print(PRE_Parser(expr))

            elseif modo == "POST" then
                print(POST_Parser(expr))

            else
                print("Debes especificar el modo: EVAL PRE exp o EVAL POST exp")
            end

        elseif opcion == "MOSTRAR" then
            if modo == "PRE" then
                print(PRE_Mostrar(expr))

            elseif modo == "POST" then
                print(POST_Mostrar(expr, "$"))

            else
                print("Debes especificar el modo: MOSTRAR PRE o MOSTRAR POST")
            end

        elseif opcion == "SALIR" then
            print("Saliendo del programa...")
            break

        else
            print("Error: opción inválida")
            print("Usage: EVAL [PRE][POST] exp, MOSTRAR [PRE][POST] exp, SALIR")
        end
    end
end

Menu()