module Enumerable
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
            |x| unless yield(x)
                return false
            end
            }
            return true
        end
    end 

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

    def my_count(parm = nil)
        return length unless block_given? || !(parm.nil?)
        unless parm.nil?
            count_parm = 0
            self.my_each{
                |x| count_parm += 1 if parm == x
            }
            return count_parm
        end
        if block_given?
            count = 0
            self.my_each{
                |x| count += 1 if yield(x)
            }
            count
        end
    end

    def my_none?(type=nil)
        if type==nil && !block_given? && self.length>0
            self.my_each {
                |x| return false if x == true
            }
            return true
        end 

        unless type.nil? && block_given?
            if type.is_a?(Regexp) == true
                self.each {
                    |x| if x =~ type
                        return false
                    end
                }
                return true
            end
            self.each {
             |x| if x.is_a?(type)
                return false
             end
            }
            return true
        end
        if block_given?
            self.each {
            |x| if yield(x)
                return false
            end
            }
            return true
        end
    end
    
end

#puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
#puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
#puts %w[ant bear cat].my_any?(/t/)                        #=> false
#puts [nil, true, 99].my_any?(Integer)                     #=> true
#puts [nil, true, 99].my_any?                              #=> true
#puts [].my_any?                                           #=> false

#puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
#puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
#puts %w[ant bear cat].my_all?(/t/)                        #=> false
#puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
#puts [nil, true, 99].my_all?                              #=> false
#puts [].my_all?                                           #=> true

#puts [1,2,3].my_each{|x| x*2}

#hash = Hash.new
#%w(cat dog wombat).my_each_with_index { |item, index|  
#  hash[item] = index
#}
#puts hash   #=>{"cat"=>0, "dog"=>1, "wombat"=>2}


#puts [1,2,3,4,5].my_select { |num|  num.even?  }

#print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]


#ary = [1, 2, 4, 2]
#puts ary.my_count               #=> 4
#puts ary.my_count(2)            #=> 2
#puts ary.my_count{ |x| x%2==0 } #=> 3

puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
puts %w{ant bear cat}.my_none?(/d/)                        #=> true
puts [1, 3.14, 42].my_none?(Float)                         #=> false
puts [].my_none?                                           #=> true
puts [nil].my_none?                                        #=> true
puts [nil, false].my_none?                                 #=> true
puts [false, false, false].my_none?                           #=> true