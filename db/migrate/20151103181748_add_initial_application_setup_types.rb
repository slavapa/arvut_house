class AddInitialApplicationSetupTypes < ActiveRecord::Migration
  def up
    ApplicationSetupType.create code_id: 1, name: 'String'
    ApplicationSetupType.create code_id: 2, name: 'Integer'
    ApplicationSetupType.create code_id: 3, name: 'Float'
    ApplicationSetupType.create code_id: 4, name: 'Attachment'
  end
 
  def down
    ApplicationSetupType.delete_all
  end
end
