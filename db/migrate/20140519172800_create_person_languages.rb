#rails generate model PersonLanguage language:references person:references
class CreatePersonLanguages < ActiveRecord::Migration
  def change
    create_table :person_languages do |t|
      t.references :language, index: true, null: false
      t.references :person, index: true, null: false

      t.timestamps
    end
    
    add_index :person_languages, ["language_id", "person_id"], unique: true
  end
end
