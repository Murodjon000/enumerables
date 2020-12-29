# rubocop:disable Style/CaseEquality
module Enumerable
  def my_each
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self
    list.length.times do |i|
      yield(list[i])
    end
    list
  end

  def my_each_with_index
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self
    list.length.times do |i|
      yield(list[i], i)
    end
    list
  end
  
  def my_select
    return enum_for unless block_given?
    selected = []
    my_each do |el|
      selected << el if yield(el)
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
    return enum_for unless block_given?
    list = is_a?(Range) ? to_a : self
    mapped = []
    if arg.nil?
      list.my_each { |ele| mapped << yield(ele)}
    else
      list.my_each { |ele| mapped << prc.call(ele)}
    end
    mapped
  end
  # rubocop:disable Metrics/CyclomaticComplexity
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
  # rubocop:enable Metrics/CyclomaticComplexity
end

def multiply_els(arr)
  arr.my_inject(:*)
end
# rubocop:enable Style/CaseEquality

