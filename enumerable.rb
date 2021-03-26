module Enumerable
def my_each
  if block_given?
    result = []
    length = self.length - 1
    (0..length).each do |i|
      result.push(yield(self[i]))
    end
    result
  end
  return "#<Enumerator: #{self}:my_each>"
end

def my_each_with_index
  if block_given?
    result = []
    length = self.length - 1
    (0..length).each do |i|
      result.push(yield(i, self[i]))
    end
    result
  end
  return "#<Enumerator: #{self}:my_each>"
end

def my_select
  result = []
  self.my_each do |x|
    result.push(x) if yield(x)
  end
  result
end

def my_map(arr)
  result = []
  self.my_each do |x|
    result.push(yield(x))
  end
  result
end

def my_any?(arr)
  self.my_each do |x|
    return true if yield(x)
  end
  false
end

def my_all?(arr)
  self.my_each do |x|
    return false unless yield(x)
  end
  true
end

def my_none?(arr)
  self.my_each do |x|
    return false if yield(x)
  end
  true
end

def my_inject?(arr, total)
  self.my_each do |x|
    total = yield(total, x)
  end
  total
end

def my_count
  unless block_given?
    return self.length
  end
  count = 0
  self.my_each do |m|  #[1,2,3,2]
    if m == yield
      count += 1 
    end
  end
  return count
end
end


s= [1,23,3].my_each
puts s