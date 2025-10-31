local socket = require("socket")

X = 6
Y = 6
Z = 4

Alpha = ((X + Y) % 5) + 3
Beta = ((Y + Z) % 5) + 3

-- Definición de F53

function F53(n)
    if n >= 0 and n < 15 then
        return n
    end

    return F53(n - Beta) + F53(n - Beta * 2) + F53(n - Beta * 3) + F53(n - Beta * 4) + F53(n - Beta * 5)

end

-- Recursión de cola de F53 sin función auxiliar

-- function F53RecurTail(n, i, baseCase)
--     if i == n then
--         return baseCase[#baseCase]
--     elseif (n < i) then
--         return n
--     end

--     local next = baseCase[13] + baseCase[10] + baseCase[7] + baseCase[4] + baseCase[1]

--     for i = 1, #baseCase - 1 do
--         baseCase[i] = baseCase[i + 1]
--     end
--     baseCase[#baseCase] = next 

--     return F53RecurTail(n, i + 1, baseCase)
-- end

-- Recursión de cola de F53

function F53RecurTail(n)
    function F35Auxiliar(n, i, baseCase)
        if i == n then
            return baseCase[#baseCase]
        elseif (n < i) then
            return n
        end

        local next = baseCase[13] + baseCase[10] + baseCase[7] + baseCase[4] + baseCase[1]

        for i = 1, #baseCase - 1 do
            baseCase[i] = baseCase[i + 1]
        end
        baseCase[#baseCase] = next 

        return F35Auxiliar(n, i + 1, baseCase)
    end

    return F35Auxiliar(n, 14, {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14})

end

-- Versión iterativa

function F53Iter(n)
    local baseCase = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}

    if n < 15 then
        return n
    end

    local i = 14

    while i < n do
        local next = baseCase[13] + baseCase[10] + baseCase[7] + baseCase[4] + baseCase[1]
        for i = 1, #baseCase - 1 do
            baseCase[i] = baseCase[i + 1]
        end
        baseCase[#baseCase] = next

        i = i + 1
    end

    return baseCase[#baseCase]
end

function Measure (f, n)
    StartTime = socket.gettime()
    f(n)
    EndTime = socket.gettime()

    return EndTime - StartTime
end

local resultados = {}

for n = 0, 90 do
    local t1 = Measure(F53, n)
    local t2 = Measure(F53RecurTail, n)
    local t3 = Measure(F53Iter, n)
    table.insert(resultados, {n, t1, t2, t3})
end

local file = io.open("resultados.csv", "w")
file:write("n,Recursion,RecursionDeCola,Iteracion\n")
for _, r in ipairs(resultados) do
    file:write(string.format("%d,%.6f,%.6f,%.6f\n", r[1], r[2], r[3], r[4]))
end
file:close()

print("Archivo resultados.csv generado con éxito.")