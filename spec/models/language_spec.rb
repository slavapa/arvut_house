#encoding: utf-8
require 'spec_helper'

describe Language do     
  before  do
    @language = Language.new(name: 'English', code: 'en')
  end 
  subject { @language }
  it { should be_valid }
   
  describe "Language attributes" do 
    it { should respond_to(:name) }
    it { should respond_to(:code) }
  end
  
  describe "Language relations" do
    it { should respond_to(:people) }  
    it { should respond_to(:person_languages) } 
  end 
  
  describe "When Language Name is not present" do
    before { @language.name = nil }
    it { should_not be_valid }    
  end
   
  describe "When Language Code is not present" do
    before { @language.code = nil }
    it { should_not be_valid }    
  end
    
  describe "When Language Name is to long" do
    before { @language.name = "a" * 61 }
    it { should_not be_valid }    
  end
    
  describe "When Language Code is to long" do
    before { @language.code = "a" * 3 }
    it { should_not be_valid }    
  end
      
  describe "When Language Code is to short" do
    before { @language.code = "a"}
    it { should_not be_valid }    
  end
  
  describe "when code format is valid" do
    it "should be valid" do
      lang = %w[he ru es]
      lang.each do |lang|
        @language.code = lang
        expect(@language).to be_valid
      end
    end
  end
  
  describe "when code format is not valid" do
    it "should be not valid" do
      lang = %w[AA aB @$ 11 2u e3 ээ אב]
      lang.each do |lang|
        @language.code = lang
        expect(@language).not_to be_valid
      end
    end
  end
  
  describe "when language name is already taken" do    
    before do
      dup_lang = @language.dup
      dup_lang.name = @language.name.upcase
      dup_lang.code = 'fr'
      dup_lang.save
    end
    it { should_not be_valid }
  end
  
  describe "when language name is already taken" do    
    before do
      dup_lang = @language.dup
      dup_lang.name = 'Germany'
      dup_lang.save
    end
    it { should_not be_valid }
  end
  
  describe "Should Create Language row in DB and change count by 1" do 
    let(:lang) { Language.new(name: 'Belarus', code: 'br') }
    
    it "should change count of languages in DB  by 1" do
      expect { lang.save }.to change(Language, :count).by(1)
    end          
  end
  
  describe "when role is already in use by person" do
    let(:lng1) { Language.new(name: 'Kazakhstan', code: 'kz') }
    let!(:person1) {FactoryGirl.create(:person)}
    before do
      lng1.save
      person1.add_language!(lng1)      
    end
    it "should not delete a role" do
      expect { lng1.destroy }.not_to change(Language, :count)
    end          
  end
  
end
