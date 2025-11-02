function Dist(n)
    if (n == 1) then return 0 end
    if (n % 2 == 0) then return 1 + Dist(n / 2) end
    if (n % 2 == 1) then return 1 + Dist(3 * n + 1) end
end

function Menu()
    io.write("Please input a number: ")
    local input = io.read()
    local n = tonumber(input)
    if not n or n <= 0 or n % 1 ~= 0 then
        print("Error: it must be a positive number.")
        return
    end
    print("Dist(" .. n .. ") = " .. Dist(n))
end

Menu()