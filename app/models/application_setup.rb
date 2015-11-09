class ApplicationSetup < ActiveRecord::Base
  after_save :reset_cache_references
  belongs_to :app_setup_type
  belongs_to :language, primary_key: "code", foreign_key: "language_code_id" 
  
  attr_readonly :id, :app_setup_type_id, :language_code_id, :code_id, :description
  
  def self.get_app_setup_value(codeId, lng = nil)
      lng ||= I18n.default_locale
      appSetupCol = where(code_id: codeId, language_code_id: lng).take
      appSetupCol = where(code_id: codeId).take if appSetupCol.nil?
      return  (appSetupCol.nil?)? nil : appSetupCol.str_value
  end
  
  def self.get_organization_name
      @@organization_name ||= Hash.new
      @@organization_name[I18n.locale] ||= 
        get_app_setup_value("organization_name", I18n.locale) || I18n.t('house_name')
  end
  
  def self.get_main_site_image_name
      @@main_site_image_name ||=  get_app_setup_value("main_site_image", 'en')
  end
   
   private
   def reset_cache_references
     @@organization_name = nil 
     @@main_site_image_name = nil
   end
end
