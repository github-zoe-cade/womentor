class CreateMentorshipCapacity < ActiveRecord::Migration[6.1]
  def change
    create_table :mentorship_capacities do |t|
      t.bigint :profile_id
      t.text :mentoring_skills, default: [], array: true
      t.text :availability
      t.integer :mentee_capacity

      t.timestamps
    end

    add_index :mentorship_capacities, :profile_id, unique: true
  end
end
