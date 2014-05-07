require 'spec_helper'

I18n.default_locale = :en


describe "Home Pages" do
  subject { page }

  # shared_examples_for "all home pages" do
    # it { should have_selector('h1', text: heading) }
    # it { should have_title(full_title(page_title)) }
  # end

  describe "Home page" do
    before { visit root_path }
    #Haifa Arvut House
    it  {should have_content(full_title(''))} 
    # let(:heading)    { 'Haifa Arvut House' }
    # let(:page_title) { 'Haifa Arvut House' }
    # it_should_behave_like "all home pages"
    
    it  {should  have_title(full_title(''))}    
    it  {should  have_link('Home', :href => root_path + '?locale=en')}
    it  {should  have_link('About us', :href => '/en' + about_path )}
    it  {should  have_link('Contact us', :href => '/en' + contact_us_path )}
    it  {should  have_link('Log in', :href => '/en' + signin_path )}
    it  {should  have_select('set_locale'), :selected => 'English'}
  end

  describe "About Us page" do
    before { visit about_path }
    it  {should  have_content('About us')}
     
    it  {should  have_title(full_title('About us'))}
  end

  describe "Contact us page" do
    before { visit contact_us_path }
    it  {should  have_content('Contact us')}
    # before { visit contact_us_path }
    # let(:heading)    { 'Contact Us' }
    # let(:page_title) { 'Contact Us' }
    # it_should_behave_like "all home pages"
    
    it  {should  have_title(full_title('Contact us'))}
  end
end
