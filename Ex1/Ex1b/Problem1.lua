function Dist(n)
    if (n == 1) then return 0 end
    if (n % 2 == 0) then return 1 + Dist(n / 2) end
    if (n % 2 == 1) then return 1 + Dist(3 * n + 1) end
end

print(Dist(42))