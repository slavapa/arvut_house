require 'spec_helper'

describe PaymentType do        
  before  do
    @payment_types = PaymentType.new(name: "Payment Type Test", frequency: 1, amount: 20.0)
  end 
  
  subject { @payment_types }
  it { should be_valid }
    
  describe "Payment Type attributes" do
    it { should respond_to(:name) } 
    it { should respond_to(:frequency) }
    it { should respond_to(:amount) }
  end
  
  describe "When Frequency is not present" do
    before { @payment_types.frequency = nil }
    it { should_not be_valid }    
  end
    
  describe "When Payment Type Name is to long" do
    before { @payment_types.name = "a" * 61 }
    it { should_not be_valid }    
  end
      
  describe "when Payment Type Frequency values are valid" do 
    it "should be valid" do   
      valid_values = [1, 2, 3, 4, 5]      
      valid_values.each do |value|
        @payment_types.frequency = value
        expect(@payment_types).to be_valid
      end      
    end 
  end    
    
  describe "when Payment Type Frequency values are not valid" do 
    it "should be invalid" do   
      valid_values = [-1, 0, 6, 10, "a"]      
      valid_values.each do |value|
        @payment_types.frequency = value
        expect(@payment_types).not_to be_valid
      end      
    end 
  end
      
  describe "when Payment Type Frequency values are valid" do 
    it "should be valid" do   
      valid_values = [0.01, 0.11, 1, 2.2, 3, 4.99, 999.99, '111.11']      
      valid_values.each do |value|
        @payment_types.amount = value
        expect(@payment_types).to be_valid
      end      
    end 
  end    
  
  describe "when Payment Type Amount values are not valid" do 
    it "should be invalid" do   
      valid_values = [-1, 0, 1.001, '1,1', "a"]      
      valid_values.each do |value|
        @payment_types.amount = value
        expect(@payment_types).not_to be_valid
      end      
    end 
  end
  
  describe "when Payment Type name is already taken" do    
    before do
      payment_type_with_same_name = @payment_types.dup
      payment_type_with_same_name.name = @payment_types.name.upcase
      payment_type_with_same_name.save
    end
    it { should_not be_valid }
  end
   
  describe "Should Create Payment Type row in DB and change count by 1" do 
    let(:pt1) { PaymentType.new(name: "Payment Type Test 1", frequency: 1) }
    
    it "should change count of Payment Type in DB  by 1" do
      expect { pt1.save }.to change(PaymentType, :count).by(1)
    end   
  end
     
  pending "Payment Type relations"
  pending "Payment Type  is already in use"
end
