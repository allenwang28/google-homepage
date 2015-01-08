module Enumerable
  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_each_with_index(offset = 0)
    return self unless block_given?
    for i in 0..self.length()-1
      yield(self[i], i)
    end
  end

  def my_select
    return self unless block_given?
    new_array = []
    new_array.my_each { |elem| new_array << elem if yield(elem) }
    return new_array
  end

  def my_all?
    if block_given?
      self.my_each { |elem| return false unless yield(elem) }
    else
      self.my_each { |elem| return false unless elem}
    end
    return true 
  end

  def my_any?
    if block_given?
      self.my_each { |elem| return true if yield(elem) }
    else
      self.my_each { |elem| return true if yield(elem) }
    end
    return false
  end

  def my_none?
    if block_given?
      self.my_each { |elem| return false if yield(elem) }
    else
      self.my_each { |elem| return false if elem } 
    end
    return true
  end

  def my_count(count = nil)
    total_count = 0
    if block_given?
      self.my_each { |elem| total_count += 1 if yield(elem) }
    elsif count.nil?
      self.my_each { |elem| total_count += 1 }
    else
      self.my_each { |elem| total_count += 1 if elem == count }
    end 
    return total_count
  end
  
  def my_map
    return self unless block_given?
    self.my_each { |elem| yield(elem) } 
    return self
  end

  def my_inject(num = nil)
    return self unless block_given?
    sum = num.nil? ? self.first : num
    self.my_each { |elem| sum = yield(sum, elem) } 
    return sum
  end

  def multiply_els(list)
    list.my_inject(1) { |product, i| product * i }
  end

end
