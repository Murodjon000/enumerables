module Enumerable

    def my_each(&prc)
      self.length.times do |i|
        prc.call(self[i])
      end
      self
    end

    def my_each_with_index(&prc)
      self.length.times do |i|
        prc.call(self[i],i)
      end
      self
    end

    
  def my_select(&prc)
    selected=[]
    self.my_each do |el|
      if prc.call(el)==true
        selected << el
      end
    end
    selected
  end


  def my_all?(arg = nil, &prc)
    if arg
      my_each { |ele| return false unless arg === ele } 
    elsif block_given?
      my_each { |ele| return false unless yield(ele) }
    else
      my_each { |ele| return false unless ele }
    end
    true
  end

  def my_any?(arg = nil, &prc)
    if arg
      my_each { |ele| return true unless arg === ele } 
    elsif block_given?
      my_each { |ele| return true unless yield(ele) }
    else
      my_each { |ele| return true unless ele }
    end
    false
  end

    
  puts "--- my_each ---"
  %w[Sharon Leo Leila Brian Arun].my_each { |friend| puts friend }
  puts "\n"

  puts "--- my_each_with_index ---"
  hash = Hash.new
  %w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
  }
  p hash  #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
  puts "\n"
  puts "--- my_select ---"
  p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

  puts "\n"
  puts "--- my_all ---"

  p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
  p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
  p %w[ant bear cat].my_all?(/t/)                        #=> false
  p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
  p [nil, true, 99].my_all?                              #=> false
  p [].all?                                              #=> true

  puts "\n"
  puts "--- my_any ---"

  p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
  p %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
  p %w[ant bear cat].any?(/d/)                        #=> false
  p [nil, true, 99].any?(Integer)                     #=> true
  p [nil, true, 99].any?                              #=> true
  p [].any?                                           #=> false


  end