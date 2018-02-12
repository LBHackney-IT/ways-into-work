module FilterrificHelper
  def filtered_range(resources, resource_name)
    if resources.total_pages == 1
      pluralize(resources.count, resource_name)
    else
      "#{start_range(resources)} - #{end_range(resources)} #{resource_name}s"
    end
  end

  private

  def start_range(resources)
    (resources.current_page - 1) * resources.current_per_page
  end

  def end_range(resources)
    [resources.current_page * resources.current_per_page, resources.total_count].min
  end
end
