function Split(t)
  local mid = math.floor(#t / 2)
  local left, right = {}, {}
  for i = 1, mid do
    left[i] = t[i]
  end
  for i = mid+1, #t do
    right[#right+1] = t[i]
  end
  return left, right
end

function MergeSort(A)
    if (#A == 1) then
        return A
    end
    local left, right = Split(A)

    return Merge(MergeSort(left), MergeSort(right))
end

function Merge(A, B)

    local merged = {}
    local i,j = 1, 1

    for k = 1, #A + #B do
        if j > #B or (i <= #A and A[i] <= B[j]) then
            table.insert(merged, A[i])
            i = i + 1
        else
            table.insert(merged, B[j])
            j = j + 1
        end
    end
    return merged
end

function PrintList(A)
    for i = 1, #A do
        io.write(A[i])
        io.write(" ")
    end
    io.write("\n")
end

PrintList(MergeSort({3,6,8,1,7}))