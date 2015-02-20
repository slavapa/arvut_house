require 'spec_helper'

describe Person do
  before { @person = Person.new(name: "Example User", 
              email: "user@example.com", 
              password: "xxxxxx", password_confirmation: "xxxxxx", admin: true )}
              
  subject { @person }
  it { should be_valid }
  
  describe "person attributes" do    
    it { should respond_to(:name) } 
    it { should respond_to(:family_name) }
    it { should respond_to(:email) }
    it { should respond_to(:phone_mob) }
    it { should respond_to(:gender) }
    it { should respond_to(:status_id) }
    it { should respond_to(:id_card_number) }
    it { should respond_to(:address) }
    it { should respond_to(:admin) }
    it { should respond_to(:password) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should be_admin }
  end
   
  describe "person relations" do
    it { should respond_to(:events) }  
    it { should respond_to(:person_event_relationships) }
    it { should respond_to(:event_types) }
    it { should respond_to(:payments) }
    it { should respond_to(:person_payments) }
  end 
    
  describe "person methods" do
    it { should respond_to(:authenticate) }
  end
  
  describe "remember token" do
    before { @person.save }
    its(:remember_token) { should_not be_blank }
  end   
   
  describe "with admin attribute set to 'false'" do
    before do
      @person.save!
      @person.toggle!(:admin)
    end
    it { should_not be_admin }
  end
  
  describe "when person name is not present" do
    before { @person.name = nil }
    it { should_not be_valid }    
  end
  
  describe "when emial name is not present but password is not blank" do
    before { @person.email = nil }
    it { should_not be_valid }    
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      emails.each do |invalid_eaddress|
        @person.email = invalid_eaddress
        expect(@person).not_to be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |valid_eaddress|
        @person.email = valid_eaddress
        expect(@person).to be_valid
      end
    end
  end
  
  it "when id card number is already taken"

  describe "when email address is already taken" do
    before do
      user_with_same_email = @person.dup
      user_with_same_email.email = @person.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @person.email = mixed_case_email
      @person.save
      expect(@person.reload.email).to eq mixed_case_email.downcase
    end
  end
  
  describe "when password doesn't match confirmation" do
    before { @person.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @person.password = @person.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "return value of authenticate method" do
    before { @person.save }
    let(:found_user) { Person.find_by(email: @person.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@person.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  
  describe "when name is too long" do
    before { @person.name = "a" * 61 }
    it { should_not be_valid }
  end
  
  describe "when family name is too long" do
    before { @person.family_name = "a" * 61 }
    it { should_not be_valid }
  end
  
  describe "when email name is too long" do
    before { @person.family_name = "a" * 61 }
    it { should_not be_valid }
  end
   
  describe "when phone is too long" do
    before { @person.phone_mob = "a" * 61 }
    it { should_not be_valid }
  end
   
  describe "when gender is too long" do
    before { @person.gender = "M" * 2 }
    it { should_not be_valid }
  end
 
  it "should describe status_id"  
  # describe "when status is too long" do
    # before { @person.status = "a" * 61 }
    # it { should_not be_valid }
  # end 
  
  describe "when cardid is too long" do
    before { @person.id_card_number = "a" * 10 }
    it { should_not be_valid }
  end 
     
  describe "when gender values are valid" do 
    it "should be valid" do   
      valid_values = [nil, "1", "2"]      
      valid_values.each do |value|
        @person.gender = value
        expect(@person).to be_valid
      end      
    end 
  end
    
  describe "when gender values are not valid" do 
    it "should be invalid" do   
      valid_values = [-1, 0, 3, "a"]      
      valid_values.each do |value|
        @person.gender = value
        expect(@person).not_to be_valid
      end      
    end 
  end
  
  describe "event associations" do    
    let(:event_type) {FactoryGirl.create(:event_type)}
    let(:event) {FactoryGirl.create(:event, event_type:event_type)}    
    let(:second_person) {FactoryGirl.create(:person, admin: false)}
    let(:third_person) {FactoryGirl.create(:person, admin: false)}
    
    before do
      @person.save
      event.add_person!(@person)
      #event.person_event_relationships.create(person_id: @person.id)
      event.add_person!(second_person)
    end   
    
    its(:events) { should include event }
    
    it "should include peaople through enent" do
      expect(event.people).to include(@person, second_person)
    end
    
    it "should not include other person" do
      expect(event.people).not_to include(third_person)
    end
    
    it "should delet person from event" do 
      people_arr = event.people.to_a
      expect(people_arr).to include(@person, second_person)
      @person.destroy      
      expect(PersonEventRelationship.where(person_id: @person.id)).to be_empty
    end
  end
  
  it "Admin value should be valid true or false" #validates_inclusion_of :field_name, in: [true, false].            
end
