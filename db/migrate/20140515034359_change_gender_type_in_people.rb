class ChangeGenderTypeInPeople < ActiveRecord::Migration
  def up
   change_column :people, :gender, 'integer USING CAST(gender AS integer)'
  end

  def down
   change_column :people, :gender, :string, limit: 1
  end
end
