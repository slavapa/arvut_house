class CreateVisitorStatuses < ActiveRecord::Migration
  def change
    create_table :visitor_statuses do |t|
      t.string :name, limit: 254, null: false
      t.string :description, limit: 254

      t.timestamps
    end
    add_index :visitor_statuses, :name, :unique => true
    
    
    reversible do |dir|
      dir.up do
        VisitorStatus.create id: 1, name: 'משתתף בכל האירועים', description: 'משתתף בכל האירועים'
        VisitorStatus.create id: 2, name: 'משתתף חלקי', description: 'משתתף חלקי'
        VisitorStatus.create id: 3, name: 'לא משתתף', description: 'לא משתתף'
        VisitorStatus.create id: 4, name: 'לא מגיב ( אין  מענה )', description: 'לא מגיב ( אין  מענה )'
        VisitorStatus.create id: 5, name: 'אחר ( לא מעוניין בקשר )', description: 'אחר ( לא מעוניין בקשר )'
      end
      dir.down do
      end
    end
    
  end
end
