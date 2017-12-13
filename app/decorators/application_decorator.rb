class ApplicationDecorator < Draper::Decorator
  
  def standard_wrapper(label, value)
    return nil if value.blank?
    h.content_tag(:p, '') do
      h.content_tag(:label, label, class: 'label') <<
        value
    end
  end
  
  def value_from(boolean)
    case boolean
    when true
      'Yes'
    when false
      'No'
    else
      'Unknown'
    end
  end
end
