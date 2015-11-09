class MainSiteImage < ActiveRecord::Migration
  
  def up
     
    ApplicationSetup.create app_setup_type_id: 4, language_code_id: 'en', 
      code_id: 'main_site_image', description: 'Main Site Image', 
      str_value: 'BAH-3.jpg'
   

  end
  
  def down
    ApplicationSetup.destroy_all(code_id: 'main_site_image')
  end
  
end
