class AddFeedbackToEnquiries < ActiveRecord::Migration[5.1]
  def change
    add_column :enquiries, :feedback, :text
  end
end
