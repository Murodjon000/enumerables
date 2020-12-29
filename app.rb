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

    
  puts "--- my_each ---"
  [1, 2, 3].my_each {|num| p num*2}
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





  end