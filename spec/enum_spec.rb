# rubocop:disable all

require 'rspec'
require_relative "../lib/app.rb"

RSpec.describe Enumerable do 
    describe '#my_each' do 
        let(:arr) {[1,2,3]}
        let(:range) {(1..5)}

        it 'should return the same array' do
            expect(arr.my_each {|el| el}).to match_array(arr)
        end

        it "should iterate range and return the same array" do
            expect(range.my_each {|el| el}).to match_array(range)
        end

        it "should iterate string and return the same array" do
            string_arr = %w[john doe man]

            expect(string_arr.my_each {|el| el}).to match_array(string_arr)
        end
        
        it "should return self when block is not given" do
            block=proc {|i| i}
            expect(range.my_each(&block)).to eq(range.each(&block))
        end

        it "should return an Enumerable if no block is given" do
            expect(arr.my_each).to be_a(Enumerable)
        end
    end


    describe '#my_each_with_index' do 
        let(:range) {(1..3)}

        it 'should iterate array and return the results' do
            empty_arr=[]
            %w[john doe man].my_each_with_index do |name,index|
                empty_arr<<name if index.even?
            end
            expect(empty_arr).to match_array(%w[john man])
        end

        it 'should work with ranges' do
            expect(range.my_each_with_index {|num,idx| idx}).to match_array([1,2,3])
        end

        it 'should return self when block is not given' do
            block=proc {|i| i} 
            expect(range.my_each_with_index(&block)).to eq(range.each_with_index(&block))
        end

        it "should return an Enumerable if no block is given" do
            expect([1, 2, 3].my_each_with_index).to be_a(Enumerable)
        end

    end

    describe '#my_select' do 
        let(:arr) {[1,2,3]}

        it 'should filter the array and return appropriate result' do
            expect(arr.my_select {|num| num.even?}).to match_array([2])
        end

        it "should return an Enumerable if no block is given" do
            expect(arr.my_select).to be_a(Enumerable)
        end
    end

    describe '#my_all?' do
        let(:string_arr) { %w[john doe mat] }

        it 'should work with an empty array' do
            expect([].my_all?).to be_truthy
        end

        it 'should return true if all the criterias match in a block' do
            expect(string_arr.my_all? {|el| el.length>1}).to be_truthy
        end

        it 'should return true if all the criterias match with an arg' do
            expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
        end
        
        it 'should return false if some of the criterias do not match in a block' do
            expect(string_arr.my_all? {|el| el.length>3}).to be_falsy
        end

        it "should return false if some of the criterias do not match with an arg" do
            expect(string_arr.my_all?(/t/) ).to be_falsy
        end
    end

    describe '#my_any?' do
        let(:string_arr) { %w[john doe man] }

        it 'should work with an empty array' do
            expect([].my_any?).to be_falsy
        end

        it 'should return true if all the criterias match in a block' do
            expect(string_arr.my_any? {|el| el.length>1}).to be_truthy
        end

        it 'should return true if all the criterias match with an arg' do
            expect([nil, true, 99].my_any?(Numeric)).to be_truthy
        end

        it "should return false if some of the criterias do not match with an arg" do
            expect(string_arr.my_any?(/t/) ).to be_falsy
        end
    end

    describe '#my_none?' do 
        let(:string_arr) { %w[john doe man] }

        it 'should work with an empty array' do
            expect([].my_none?).to be_truthy
        end

        it 'should return true if all the criterias match in a block' do
            expect(string_arr.my_none? {|el| el.length==5}).to be_truthy
        end

        it 'should return true if all the criterias match with an arg' do
            expect([1, 3.14, 42].my_none?(Float)).to be_falsy
        end

        it "should return false if some of the criterias do not match with an arg" do
            expect(string_arr.my_none?(/t/) ).to be_truthy
        end
    end

    describe '#my_count' do 
        let(:arr) {[1,2,3,1]}

        it 'should return the result when no block or arg is passed' do
            expect(arr.my_count).to eq(4)
        end

        it 'should return result when arg is given' do
            expect(arr.my_count(1)).to eq(2)
        end

        it 'shoud return result when block is given' do
            expect(arr.my_count {|x| x.even?}).to eq(1)
        end
    end

    describe '#my_map' do 
        let(:range) {(1..4)}

        it 'should return result when range is given' do 
            expect(range.my_map {|i| i * i }).to match_array([1, 4, 9, 16])
        end

        it 'should work with proc' do 
            block=proc {|i| i * i }
            expect(range.my_map(&block)).to match_array([1, 4, 9, 16])
        end

        it 'should return an Enumerable if no block is given' do
            expect([1, 2, 3].my_map).to be_a(Enumerable)
          end
        
    end

    describe '#my_inject' do
        let(:range) {(1..4)}

        it 'should work with blocks' do 
            expect(range.my_inject {|sum,el| sum+el}).to eq(10)
        end

        it 'should work with a combination of block and arg' do
            expect(range.my_inject(1) {|sum,el| sum*el}).to eq(24)
        end

        it 'should work with initial value and symbol passed as an arg' do
            expect(range.my_inject(1, :+)).to eq(11)
          end
      

        it 'should  work with block' do
            longest =
            %w[ant bear cat].my_inject do |memo, word|
              memo.length > word.length ? memo : word
            end
            expect(longest).to eq('bear')
        end

        it 'should work with multiply_els' do 
            expect(multiply_els([2, 4, 5])).to eq(40)
        end
    end
end

# rubocop:enable all
