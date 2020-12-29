# rubocop:disable all
require './lib/app.rb'

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

p %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].all?(/t/)                        #=> false
p [1, 2i, 3.14].all?(Numeric)                       #=> true
p [nil, true, 99].all?                              #=> false
p [].all?                                           #=> true
p [1, 'string', true].all?
p [1, 'string', nil].all?

puts "\n"
puts "--- my_any ---"

p %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].any?(/d/)                        #=> false
p [nil, true, 99].any?(Integer)                     #=> true
p [nil, true, 99].any?                              #=> true
p [].any?                                           #=> false
p [1, false, nil].any?                              #=> true
p [nil, false, nil].any?                            #=> false
p [1, false, nil].any?(Numeric)                     #=> true 
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
p [nil, nil, nil].none?                                #=> true
p [1, 'string', true].none?                           #=> false   

puts "\n"
puts "--- my_count ---"
ary = [1, 2, 4, 2]
p ary.my_count               #=> 4
p ary.my_count(2)            #=> 2
p ary.my_count { |x| x%2==0 } #=> 3

puts "\n"
puts "--- my_map ---"

p ((1..4).my_map { |i| i * i })     #=> [1, 4, 9, 16]  

puts "\n"

puts 'my_map_proc'
my_proc = proc { |i| i * i }
puts (1..4).my_map(my_proc) { |i| i * i } #=> [1, 4, 9, 16] 

puts "\n"
puts "--- my_inject ---"

# Sum some numbers
p (5..10).my_inject(:+)                             #=> 45
# Same using a block and inject
p (5..10).my_inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
p (5..10).my_inject(1, :*)                          #=> 151200
# Same using a block
p [1, 2, 3].my_inject(0, :+)

p (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.my_inject do |memo, word|
 memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"

puts "\n"
puts "--- my_inject-multp ---"
p multiply_els([2,4,5]) #=> 40
# rubocop:enable all