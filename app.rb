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

 def my_none?(arg = nil, &prc)
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
    counted=0
    if block_given?
     my_each {|ele| counted+=1 if prc.call(ele)}
    elsif !block_given? && arg.nil?
      counted=to_a.length
    else
      counted=to_a.my_select {|ele| ele==arg}.length
    end
    counted
  end

  def my_map(arg = nil,&prc)
    mapped=[]
    if arg
      self.to_a.my_each {|ele| mapped << yield(ele)}
    else
      self.to_a.my_each {|ele| mapped << prc.call(ele)}
    end
    mapped
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
 
  puts "\n"
  puts "--- my_none ---"
  p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
  p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
  p %w{ant bear cat}.my_none?(/d/)                        #=> true
  p [1, 3.14, 42].my_none?(Float)                         #=> false
  p [].my_none?                                           #=> true
  p [nil].my_none?                                        #=> true
  p [nil, false].my_none?                                 #=> true
  p [nil, false, true].my_none?                           #=> false  

  puts "\n"
  puts "--- my_count ---"
  ary = [1, 2, 4, 2]
  p ary.my_count               #=> 4
  p ary.my_count(2)            #=> 2
  p ary.my_count { |x| x%2==0 } #=> 3

  puts "\n"
  puts "--- my_map ---"

  p ((1..4).my_map { |i| i * i })     #=> [1, 4, 9, 16]  

  puts 'my_map_proc'
  my_proc = proc { |i| i * i }
  puts (1..4).my_map(my_proc) { |i| i * i } #=> [1, 4, 9, 16] 


  end