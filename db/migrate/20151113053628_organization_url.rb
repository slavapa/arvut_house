class OrganizationUrl < ActiveRecord::Migration
  
  def up
     
    ApplicationSetup.create app_setup_type_id: AppSetupType::STRING, language_code_id: 'en', 
      code_id: 'organization_url', description: 'Organization URL', 
      str_value: 'http://www.kab.co.il/'
   

  end
  
  def down
    ApplicationSetup.destroy_all(code_id: 'organization_url')
  end
  
end
