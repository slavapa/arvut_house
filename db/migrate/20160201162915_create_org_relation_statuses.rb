#encoding: utf-8

class CreateOrgRelationStatuses < ActiveRecord::Migration
  def change
    create_table :org_relation_statuses do |t|
      t.string :name, limit: 60, null: false
      t.string :description

      t.timestamps
    end
    
    reversible do |dir|
      dir.up do
        change_column_null :org_relation_statuses, :id, false
        OrgRelationStatus.create id: 1, name: 'חבר', description: 'חבר קבוצה'
        OrgRelationStatus.create id: 2, name: 'קבוצה צעירה', description: 'קבוצה צעירה'
        OrgRelationStatus.create id: 3, name: 'אורח', description: 'אורח'
      end
      dir.down do
      end
    end
  end
end
