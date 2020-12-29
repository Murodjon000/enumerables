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

    num_arr = [1, 2, 3]
    
  puts "--- my_each ---"
  p num_arr.my_each { |n| n }
  num_arr.my_each do |n|
      puts n*2 
  end
  puts "\n"

  puts "--- my_each_with_index ---"
  p num_arr.my_each_with_index { |n,ind| "#{n} is #{ind}" }
  num_arr.my_each_with_index do |n,ind|
    puts "#{n} is #{ind}"
  end

  puts "\n"

  hash = Hash.new
  %w(cat dog wombat).my_each_with_index { |item, index|
  hash[item] = index
  }
  p hash 
  puts "\n"

  end