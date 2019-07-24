require './lib/enumerable_methods.rb'

describe Enumerable do

    #test data
    let(:test_arr) { [1,2,3,4,5] }
    let(:result) { [] }
    let(:test_hash) { {
        one: 1,
        two: 2,
        three: 3,
        four: 4,
        five: 5
    } }


    describe "#my_select" do
        it "returns array containing all the values for which the block evaluated to true" do
            expect(test_arr.my_select { |value| value > 2 }).to eql([3,4,5])
        end

        it "returns a hash containing the correct key, value pairs" do
            expect(test_hash.my_select { |key, value| value > 2}).to eql({three: 3, four: 4, five: 5})
        end        
    end

    describe "#my_all?" do
        it "returns true after block criteria is satisfied for every value" do
            expect(test_arr.my_all? { |value| value < 10 } ).to eql(true)
        end

        it "returns false if one value does not match block criteria" do
            expect(test_arr.my_all? { |value| value < 5 } ).to eql(false) 
        end
    end

    describe "#my_any?" do
        it "returns true if at least one value matches block criteria" do
            expect(test_arr.my_any? { |value| value > 4 } ).to eql(true)
        end

        it "returns false if all the values does not match block criteria" do
            expect(test_arr.my_any? { |value| value > 5 }).to eql(false)
        end
    end

    describe "#my_each_with_index" do
        it "calls the block for each element and its index" do
            test_arr.my_each_with_index { |value, index| result << (value + index) }
            expect(result).to eql([1,3,5,7,9])
        end
    end

    
    describe "#my_none?" do
        it "returns true if no values match the given block" do
            expect(test_arr.my_none? { |value| value > 5 }).to eql(true)
        end

        it "returns false if at least one of the values match the given block" do
            expect(test_arr.my_none? { |value| value < 5 }).to eql(false)
        end
    end

end