
def my_each(arr)
    result = []
    length = arr.length-1
    for i in 0..length
      result.push(yield(arr[i]))
    end
    result
end

def my_each_with_index(arr)
    result = []
    length = arr.length-1
    for i in 0..length
      result.push(yield(i,arr[i]))
    end
    result
end
def my_select(arr)
    result = []
    my_each(arr) do |x|
      if yield(x)
        result.push(x)
      end
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
      if yield(x)
        return true
      end
    end
    return false
end
my_map(["marwen","ali","salah"]){|i| puts"#{i}"}