def my_each(arr)
    result = []
    length = arr.length-1
    for i in 0..length
      result.push(arr[i])
    end
    result
end
puts my_each([1,2,3,4,5,6])