class CreateAppSetupTypes < ActiveRecord::Migration
  def change
    create_table(:app_setup_types) do |t|
      t.string :name, limit: 60, null: false
      t.string :description

      t.timestamps
    end
    reversible do |dir|
      dir.up do
        change_column_null :app_setup_types, :id, false
        AppSetupType.create id: 1, name: 'String'
        AppSetupType.create id: 2, name: 'Integer'
        AppSetupType.create id: 3, name: 'Float'
        AppSetupType.create id: 4, name: 'Attachment'
      end
      dir.down do
      end
    end
  end
end
