require 'spec_helper'

describe PersonLanguage do  
  let(:person1) { FactoryGirl.create(:person, admin: false) }
  let(:lng1) {FactoryGirl.create(:language, name: 'Language 1', code: 'aa')}
  
  before do
    @person_language = person1.person_languages.build(language_id: lng1.id)
  end  
  
  subject { @person_language } 
   
  it { should be_valid }
  its(:person) { should eq person1 }
  its(:language) { should eq lng1 }
    
  describe "person_languages attributes" do 
    it { should respond_to(:person_id) }
    it { should respond_to(:language_id) }
  end
    
  describe "person_languages relations attributes" do
    it { should respond_to(:language) }  
    it { should respond_to(:person) } 
  end 
      
  it "should increase rows" do
    expect { @person_language.save }.to change(PersonLanguage, :count).by(1)
  end       
    
  describe "when person_id is not present" do
    before { @person_language.person_id = nil }
    it { should_not be_valid }
  end
   
  describe "when language_id is not present" do
    before { @person_language.language_id = nil }
    it { should_not be_valid }
  end 
  
  describe "should check foregn key to people" do
    before { 
      @person_language.person_id = -1 
    }
    it { should_not be_valid }
       
    it "should not add row when person_id is invalid" do
      expect { @person_language.save }.not_to change(PersonLanguage, :count)
    end
  end
  
  describe "should check foregn key to languages" do
    before { 
      @person_language.language_id = -1 
    }
    it { should_not be_valid }
       
    it "should not add row when language_id is invalid" do
      expect { @person_language.save }.not_to change(PersonLanguage, :count)
    end
  end
    
end
