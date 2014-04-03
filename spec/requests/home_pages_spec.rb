require 'spec_helper'

I18n.default_locale = :en


describe "Home Pages" do
  subject { page }

  shared_examples_for "all home pages" do
    it { should have_selector('h1', text: heading) }
    #it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Haifa Arvut House' }
    let(:page_title) { 'Haifa Arvut House' }
    it_should_behave_like "all home pages"
  end

  describe "About Us page" do
    before { visit about_path }
    let(:heading)    { 'About Us' }
    let(:page_title) { 'About Us' }
    it_should_behave_like "all home pages"
  end

  describe "Contact Us page" do
    before { visit contact_us_path }
    let(:heading)    { 'Contact Us' }
    let(:page_title) { 'Contact Us' }
    it_should_behave_like "all home pages"
  end
end
