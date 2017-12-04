class ReJigClientFields < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :preferred_contact_method, :string, default: nil

    add_column :clients, :qualifications, :string, array: true, default: []
    add_column :clients, :other_qualification, :string

    add_column :clients, :training_courses, :string, array: true, default: []
    add_column :clients, :other_training_course, :string

    add_column :clients, :type_of_works, :string, array: true, default: []
    add_column :clients, :other_type_of_work, :string

    # Tracking equalities
    add_column :clients, :gender, :string, default: nil

    add_column :clients, :has_children, :boolean, default: nil
    add_column :clients, :lone_parent, :boolean, default: nil
    add_column :clients, :receive_benefits, :boolean, default: nil
    add_column :clients, :below_living_wage, :boolean, default: nil
    add_column :clients, :affected_by_welfare_reform, :boolean, default: nil
    add_column :clients, :care_leaver, :boolean, default: nil
  end
end
