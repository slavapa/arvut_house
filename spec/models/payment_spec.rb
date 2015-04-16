require 'spec_helper'

describe Payment do        
  before  do 
    @payment_type = FactoryGirl.create(:payment_type, frequency: 1, name:'ptp1')
    @person = FactoryGirl.create(:person, admin: false)
    @payment = FactoryGirl.create(:payment, payment_type: @payment_type, 
                                    description: 'Payment for Test 1')
  end 
  
  subject { @payment }
  
  it { should be_valid }
  
  describe "event attributes" do 
    it { should respond_to(:payment_date) }
    it { should respond_to(:description) }
    it { should respond_to(:payment_type_id) }
  end
  
  describe "event relations" do
    it { should respond_to(:payment_type) }  
    it { should respond_to(:people) } 
    it { should respond_to(:person_payments) }
  end 
  
  its(:payment_type) { should eq @payment_type } 
   
  describe "when payment is valid" do
    before { @payment.save }
    it { should be_valid }
  end
   
  describe "Should Create Payment row in DB and change count by 1" do 
    let(:person1) { FactoryGirl.create(:person, admin: false) }
    let(:payment_type1) {FactoryGirl.create(:payment_type, frequency: 2)}
    let(:payment1) {FactoryGirl.create(:payment, payment_type: payment_type1, 
                    description: 'Payment for Test 1')}
    
    it "should change count of Role in DB  by 1" do
      expect { payment1.save }.to change(Payment, :count).by(1)
    end          
  end 
   
  describe "when pyment tpe id is not present" do
    before { @payment.payment_type_id = nil }
    it { should_not be_valid }    
  end
  
  describe "when payment date is not present" do
    before { @payment.payment_date = nil }
    it { should_not be_valid }    
  end
   
  describe "when payment type id is not valid" do
    before {@payment.payment_type_id = -1}
    it { should_not be_valid }    
  end
   
  describe "with description that is too long" do
    before { @payment.description = "a" * 256 }
    it { should_not be_valid }
  end
    
  describe "with description that is size 255" do
    before { @payment.description = "a" * 255 }
    it { should be_valid }
  end 
    
  describe "with description is not present" do
    before { @payment.description = nil }
    it { should be_valid }
  end 
  
  
  describe "people association" do
    let(:second_person) {FactoryGirl.create(:person, admin: false)}
    let(:third_person) {FactoryGirl.create(:person, admin: false)}
    let(:not_related_person) {FactoryGirl.create(:person, admin: false)}
    before do
      @payment.save
      @payment.add_person!(@person)
      @payment.add_person!(second_person)
      @payment.add_person!(third_person)
    end     
    
    its(:people) { should include @person } 
    its(:people) { should include second_person }
    its(:people) { should include third_person } 
    its(:people) { should_not include not_related_person }
    
        
    it "should exists all peaople by is_perosn_exists" do
      expect(PersonPayment.where(person_id: @person.id)).not_to be_empty
      expect(PersonPayment.where(person_id: second_person.id)).not_to be_empty
      expect(PersonPayment.where(person_id: third_person.id)).not_to be_empty
      expect(PersonPayment.where(person_id: not_related_person.id)).to be_empty
    end 
    
    it "should remove person by remove_person!" do
      @payment.remove_person!(second_person)
      expect(PersonPayment.where(person_id: second_person.id)).to be_empty     
    end 
    
    it "should have the right peaople in the right order" do
      expect(@payment.people.to_a).to eq [@person, second_person, third_person]
    end 
    
    it "should destroy all releshions when payment is deleted" do      
      people_arr = @payment.people.to_a
      expect(people_arr).to include(@person, second_person, third_person)
      @payment.destroy  
            
      people_arr.each do |lup_person|
        expect(PersonPayment.where(person_id: lup_person.id)).to be_empty
      end
    end  
  end
  
  
  pending "payment type id and payment date is already taken" do
    before do
      @payment.save
      payment_with_same_data = @payment.dup
      payment_with_same_data.save
    end
    it { should_not be_valid }
  end
  
end
