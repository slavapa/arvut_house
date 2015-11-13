class ApplicationSetup < ActiveRecord::Base
  after_save :reset_cache_references
  belongs_to :app_setup_type
  belongs_to :language, primary_key: "code", foreign_key: "language_code_id" 
  
  attr_readonly :id, :app_setup_type_id, :language_code_id, :code_id, :description
  
  def setup_type_array
    if defined?(@@setup_tyep_array).nil? || @@setup_type_array.nil?
      @@setup_type_array = Hash.new
      AppSetupType.all.map do |setupType| 
        @@setup_type_array[setupType.id] = setupType.name
      end
    end
    @@setup_type_array
  end 

  def self.reset_setup_type_array
    @@setup_type_array = nil
  end  
  
  def setup_type_name_by_hash
    setup_type_array[app_setup_type_id] 
  end

  
  def self.get_app_setup_value(codeId, lng = nil)
      lng ||= I18n.default_locale
      appSetupCol = where(code_id: codeId, language_code_id: lng).take
      appSetupCol = where(code_id: codeId).take if appSetupCol.nil?
      return  (appSetupCol.nil?)? nil : appSetupCol.str_value
  end
  
  def self.get_organization_name
    keyName = "organization_name_#{I18n.locale}"
    app_setup_cach[keyName] ||= 
        get_app_setup_value("organization_name", I18n.locale) || I18n.t('house_name')
  end
  
  def self.get_site_main_image_name
    keyName = "main_site_image_#{I18n.locale}"
    app_setup_cach[keyName] ||= 
        get_app_setup_value("site_main_image", I18n.locale)
  end
    
  def self.get_organization_url
    keyName = "organization_url#{I18n.locale}"
    app_setup_cach[keyName] ||= 
        get_app_setup_value("organization_url", I18n.locale)
  end
  
  def self.app_setup_cach
    @@app_setup_cach ||= Hash.new
  end
   
   private
   def reset_cache_references
     @@app_setup_cach = nil 
   end
end
