class CreateExpectation < ActiveRecord::Migration[6.1]
  def change
    create_table :expectations do |t|
      t.bigint :profile_id
      t.text :mentoring_skills, default: [], array: true
      t.text :availability
      t.text :expertise
      t.text :technologies, default: [], array: true
      t.text :industry
      t.text :job_type

      t.timestamps
    end

    add_index :expectations, :profile_id, unique: true
  end
end
