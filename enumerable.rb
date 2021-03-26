def my_each(arr)
  result = []
  length = arr.length - 1
  (0..length).each do |i|
    result.push(yield(arr[i]))
  end
  result
end

def my_each_with_index(arr)
  result = []
  length = arr.length - 1
  (0..length).each do |i|
    result.push(yield(i, arr[i]))
  end
  result
end

def my_select(arr)
  result = []
  my_each(arr) do |x|
    result.push(x) if yield(x)
  end
  result
end

def my_map(arr)
  result = []
  my_each(arr) do |x|
    result.push(yield(x))
  end
  result
end

def my_any?(arr)
  my_each(arr) do |x|
    return true if yield(x)
  end
  false
end

def my_all?(arr)
  my_each(arr) do |x|
    return false unless yield(x)
  end
  true
end

def my_none?(arr)
  my_each(arr) do |x|
    return false if yield(x)
  end
  true
end

def my_inject?(arr, total)
  my_each(arr) do |x|
    total = yield(total, x)
  end
  total
end

def my_count(arr)
  count=arr.length
  count
end

puts my_count([1,3,4,5])