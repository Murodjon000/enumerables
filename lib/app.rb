module Enumerable
  def my_each(&prc)
    length.times do |i|
      prc.call(self[i])
    end
    self
  end

  def my_each_with_index(&prc)
    length.times do |i|
      prc.call(self[i], i)
    end
    self
  end
  
  def my_select(&prc)
    selected = []
    my_each do |el|
      selected << el if prc.call(el) == true
    end
    selected
  end
  
  def my_all?(arg = nil)
    if arg
      my_each { |ele| return false unless arg === ele }
    elsif block_given?
      my_each { |ele| return false unless yield(ele) }
    else
      my_each { |ele| return false unless ele }
    end
    true
  end

  def my_any?(arg = nil)
    if arg
      my_each { |ele| return true unless arg === ele }
    elsif block_given?
      my_each { |ele| return true unless yield(ele) }
    else
      my_each { |ele| return true unless ele }
    end
    false
  end
  
  def my_none?(arg = nil)
    if arg
      my_each { |ele| return false if arg === ele }
    elsif block_given?
      my_each { |ele| return false if yield(ele) }
    else
      my_each { |ele| return false if ele }
    end
    true
  end
  
  def my_count(arg = nil, &prc)
    counted = 0
    if block_given?
      my_each { |ele| counted += 1 if prc.call(ele) }
    elsif !block_given? && arg.nil?
      counted = to_a.length
    else
      counted = to_a.my_select { |ele| ele == arg}.length
    end
    counted
  end
  
  def my_map(arg = nil, &prc)
    list = is_a?(Range) ? to_a : self
    mapped = []
    if arg
      list.my_each { |ele| mapped << yield(ele)}
    else
      list.my_each { |ele| mapped << prc.call(ele)}
    end
    mapped
  end

  def my_inject(*args)
    reduce = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]
  
    if operator
      to_a.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
      return reduce
    end
    to_a.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
    reduce
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end


