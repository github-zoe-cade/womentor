class CreateProfile < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.bigint :user_id
      t.boolean :is_mentor
      t.boolean :is_mentee
      t.text :name
      t.text :github_url
      t.text :linkedin_url
      t.integer :seniority
      t.text :expertise
      t.text :technologies, default: [], array: true
      t.text :industry
      t.text :job_type

      t.timestamps
    end

    add_index :profiles, :user_id, unique: true
  end
end
