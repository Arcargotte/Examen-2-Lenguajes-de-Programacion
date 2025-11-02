function RemoveWhitespaces(str)
    return string.gsub(str, "%s+", "")
end

function PRE_Parser (expression) 

    local function calc (operator, leftValue, rightValue)
        if (operator == "+") then
            return leftValue + rightValue
        elseif (operator == "*") then
            return leftValue * rightValue
        elseif (operator == "/") then
            return leftValue / rightValue
        elseif (operator == "-") then
            return leftValue - rightValue
        else
            return "Ups"
        end
    end

    if (#expression ~= 0 and (string.sub(expression, 1, 1) ~= "+" and string.sub(expression, 1, 1) ~= "*" and string.sub(expression, 1, 1) ~= "-" and string.sub(expression, 1, 1) ~= "/")) then
        return tonumber(string.sub(expression, 1, 1)), string.sub(expression, 2, #expression)
    else
        local leftValue, rest1 = PRE_Parser(string.sub(expression, 2, #expression))
        local rightValue, rest2 = PRE_Parser(rest1)

        return calc(string.sub(expression, 1, 1), leftValue, rightValue), rest2
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
        local right = tonumber(Pop(Stack))
        local left = tonumber(Pop(Stack))
        Push(Stack, left / right)
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
    local function printExpr (operator, leftValue, rightValue, appendParenthesis)
        if(appendParenthesis) then
            if (operator == "+") then
                return "(" .. leftValue .. " + " .. rightValue .. ")"
            elseif (operator == "*") then
                return "(" .. leftValue .. " * " .. rightValue .. ")"
            elseif (operator == "/") then
                return "(" .. leftValue .. " / " .. rightValue .. ")"
            elseif (operator == "-") then
                return "(" .. leftValue .. " - " .. rightValue .. ")"
            else
                return "(Ups)"
            end
        else
            if (operator == "+") then
                return leftValue .. " + " .. rightValue
            elseif (operator == "*") then
                return leftValue .. " * " .. rightValue
            elseif (operator == "/") then
                return leftValue .. " / " .. rightValue
            elseif (operator == "-") then
                return leftValue .. " - " .. rightValue
            else
                return "Ups"
            end
        end
    end

    if (#expression ~= 0 and (string.sub(expression, 1, 1) ~= "+" and string.sub(expression, 1, 1) ~= "*" and string.sub(expression, 1, 1) ~= "-" and string.sub(expression, 1, 1) ~= "/")) then
        return string.sub(expression, 1, 1), string.sub(expression, 2, #expression)
    else
        local leftValue, rest1 = PRE_Mostrar(string.sub(expression, 2, #expression), string.sub(expression, 1, 1))
        local rightValue, rest2 = PRE_Mostrar(rest1, string.sub(expression, 1, 1))
        local placeParenthesis = PrecedenteTable[string.sub(expression, 1, 1)] < PrecedenteTable[lastOperation]

        return printExpr(string.sub(expression, 1, 1), leftValue, rightValue, placeParenthesis), rest2
    end
    
end

function POST_Mostrar(expression, lastOperation)

    if (#expression == 0) then
        return Top(Stack)
    end

    Push(Stack, string.sub(expression, 1, 1))

    if ((Top(Stack) == "+" or Top(Stack) == "-" or Top(Stack) == "*" or Top(Stack) == "/") and lastOperation == "$") then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), operator)
    elseif ((Top(Stack) == "+" or Top(Stack) == "-" or Top(Stack) == "*" or Top(Stack) == "/") and (PrecedenteTable[Top(Stack)] > PrecedenteTable[lastOperation])) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)

        if (PrecedenteTable[string.sub(left, 3, 3)] and PrecedenteTable[string.sub(right, 3, 3)] and PrecedenteTable[string.sub(left, 3, 3)] < PrecedenteTable[operator] and PrecedenteTable[string.sub(right, 3, 3)] < PrecedenteTable[operator]) then
            Push(Stack, "(" .. left .. ") " .. operator .. " (" .. right .. ")")
        elseif (PrecedenteTable[string.sub(left, 3, 3)] and PrecedenteTable[string.sub(left, 3, 3)] < PrecedenteTable[operator]) then
            Push(Stack, "(" .. left .. ") " .. operator .. " " .. right)
        elseif (PrecedenteTable[string.sub(right, 3, 3)] and PrecedenteTable[string.sub(right, 3, 3)] < PrecedenteTable[operator]) then
            Push(Stack, left .. " " .. operator .. " ("  .. right .. ")")
        else
            Push(Stack, left .. " " .. operator .. " " .. right)
        end

        return POST_Mostrar(string.sub(expression, 2, #expression), operator)
    elseif ((Top(Stack) == "+" or Top(Stack) == "-" or Top(Stack) == "*" or Top(Stack) == "/") and (PrecedenteTable[Top(Stack)] <= PrecedenteTable[lastOperation])) then
        local operator = Pop(Stack)
        local right = Pop(Stack)
        local left = Pop(Stack)
        Push(Stack, left .. " " .. operator .. " " .. right)
        return POST_Mostrar(string.sub(expression, 2, #expression), operator)
    end

    return POST_Mostrar(string.sub(expression, 2, #expression), lastOperation)
end

function Menu()
    while true do
        io.write("\nEscribe una opcion (EVAL, MOSTRAR, SALIR): ")
        local input = string.upper(io.read())

        local opcion, modo, expr = string.match(input, "(%S+)%s*(%S*)%s*(.*)")

        if opcion == "EVAL" then
            if modo == "PRE" then
                expr = RemoveWhitespaces(expr)
                local ok, result = pcall(PRE_Parser, expr)
                if (ok) then
                    print(result)
                else
                    print("Verificar expresión. Expresión es inválida")
                end

            elseif modo == "POST" then
                expr = RemoveWhitespaces(expr)
                local ok, result = pcall(POST_Parser, expr)
                if (ok) then
                    print(result)
                else
                    print("Verificar expresión. Expresión es inválida")
                end

            else
                print("Debes especificar el modo: EVAL PRE expr o EVAL POST expr")
            end

        elseif opcion == "MOSTRAR" then
            if modo == "PRE" then
                expr = RemoveWhitespaces(expr)
                local ok, result = pcall(PRE_Mostrar, expr, "$")
                if (ok) then
                    print(result)
                else
                    print("Verificar expresión. Expresión es inválida")
                end

            elseif modo == "POST" then
                expr = RemoveWhitespaces(expr)
                local ok, result = pcall(POST_Mostrar, expr, "$")
                if (ok) then
                    print(result)
                else
                    print("Verificar expresión. Expresión es inválida")
                end

            else
                print("Debes especificar el modo: MOSTRAR PRE o MOSTRAR POST")
            end

        elseif opcion == "SALIR" then
            print("Saliendo del programa...")
            break

        else
            print("Error: opción inválida")
            print("Usage: EVAL [PRE][POST] expr, MOSTRAR [PRE][POST] expr, SALIR")
        end
    end
end

Menu()