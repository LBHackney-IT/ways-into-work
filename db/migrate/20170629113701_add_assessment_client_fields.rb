class AddAssessmentClientFields < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_notes do |t|
      t.text :content
      t.string :content_key
      t.belongs_to :client
    end
    add_index :assessment_notes, %i[content_key client_id], unique: true

    add_column :clients, :rag_status, :integer, default: 0
    remove_column :clients, :time_since_last_job, :string
  end
end
