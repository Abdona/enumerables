module Enumerable
  def my_each
    new_arr=[]
    for item in self do
        new_arr.push(yield(item))
    end
    new_arr
end

def my_each_with_index
    new_arr=[]
    for i in (0...self.length) do
        new_arr.push(yield(self[i],i))
    end
    new_arr
end

  def my_select
    result = []
    my_each do |x|
      result.push(x) if yield(x)
    end
    result
  end

  def my_map
    result = []
    my_each do |x|
      result.push(yield(x))
    end
    result
  end

  def my_any?(type=nil)
    return true if type==nil && !block_given? && self.length>0

    unless type.nil? && block_given?
        if type.is_a?(Regexp)==true
            self.each {
                |x| if x =~ type
                    return true
                end
            }
            return false
        end
        self.each {
         |x| if x.is_a?(type)
            return true
         end
        }
        return false
    end
    if block_given?
        self.each {
        |x| if yield(x)
            return true
        end
        }
        return false
    end
end

def my_all?(type=nil)
return true if self.length == 0
return false if type==nil && !block_given?

unless type.nil? && block_given?
    if type.is_a?(Regexp)==true
        self.each {
            |x| if !(x =~ type)
                return false
            end
        }
        return true
    end
    self.each {
     |x| if !(x.is_a?(type))
        return false
     end
    }
    return true
end
if block_given?
    self.each {
    |x| if !(yield(x))
        return false
    end
    }
    return true
end
end

  def my_none?
    my_each do |x|
      return false if yield(x)
    end
    true
  end

  def my_inject?(_arr, total)
    my_each do |x|
      total = yield(total, x)
    end
    total
  end

  def my_count
    return length unless block_given?

    count = 0
    my_each do |m|
      count += 1 if yield == m
    end
    count
  end

