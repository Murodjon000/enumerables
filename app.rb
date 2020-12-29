module Enumerable

    def my_each(&prc)
      self.length.times do |i|
        prc.call(self[i])
      end
      self
    end

    num_arr = [1, 2, 3]
    
    puts "each ---"
    p num_arr.my_each { |n| n }
    num_arr.my_each do |n|
      puts n*2 
    end
    puts "\n"

  end