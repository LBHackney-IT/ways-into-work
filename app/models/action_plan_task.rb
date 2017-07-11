class ActionPlanTask < ApplicationRecord

  validates :due_date, :title, :client, presence: true

  enum status: [ :ongoing, :completed ]

  belongs_to :client
  belongs_to :advisor #optional

  def task_owner_name
    (advisor || client).name
  end

end
