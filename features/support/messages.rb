include ActionView::Helpers::TagHelper

module FlashMessageHelpers
  def message_content_for(message_name)
    case message_name
    when /some message/
      "Some message"

    else
      raise "Can't find mapping from \"#{message_name}\" to a flash message.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(FlashMessageHelpers)
