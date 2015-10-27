require 'rails_helper'

describe PersonPayment do
  let(:person1) { FactoryGirl.create(:person, admin: false) }
  let(:payment_type1) {FactoryGirl.create(:payment_type, frequency: 1)}
  let(:payment1) {FactoryGirl.create(:payment, payment_type: payment_type1, 
                    description: 'Payment for Test 1')}
  #{payment_type1.payments.create(description: 'Payment Descr For Test Paymen1')}#
  
  before do
    @person_payment = payment1.person_payments.build(person_id: person1.id)
  end  
  
  subject { @person_payment }
  
  it { should be_valid }
  its(:person) { should eq person1 }
  its(:payment) { should eq payment1 }
   
  describe "payment type relation" do
    before { @person_payment.save}
    its(:payment_type) { should eq payment_type1 }    
  end
  
  describe "person_payment attributes" do 
    it { should respond_to(:person_id) }
    it { should respond_to(:payment_id) }
    it { should respond_to(:amount) }
  end
      
  describe "when person_id is not present" do
    before { @person_payment.person_id = nil }
    it { should_not be_valid }
  end
   
  describe "when payment_id is not present" do
    before { @person_payment.payment_id = nil }
    it { should_not be_valid }
  end
   
  describe "when amount is not valid" do    
    it "should be invalid" do   
      not_valid_values = [-1, 0, -99, -999, 1.999, 99.101, '1,1', "a"]      
      not_valid_values.each do |value|
        @person_payment.amount = value
        expect(@person_payment).not_to be_valid
      end      
    end 
  end
   
  describe "when amount is valid" do    
    it "should be valid" do   
      valid_values = [1, 10.55, 100.01, 999.99, 0.10, '111.11']      
      valid_values.each do |value|
        @person_payment.amount = value
        expect(@person_payment).to be_valid
      end      
    end 
  end
  
  
  describe "should check foregn key to people" do
    before { @person_payment.person_id = -1 }
    it { should_not be_valid }       
    it "should not add row when person_id is invalid" do
      expect { @person_payment.save }.not_to change(PersonPayment, :count)
    end
  end
  
  describe "should check foregn key to payment" do
    before {@person_payment.payment_id = -1 }
    it { should_not be_valid }
       
    it "should not add row when payment_id is invalid" do
      expect { @person_payment.save }.not_to change(PersonPayment, :count)
    end
  end
end
