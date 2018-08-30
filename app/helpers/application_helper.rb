module ApplicationHelper
  def error_messages_for(object, attribute, alignment="right")
    if object.errors.messages[attribute].present?
      messages = object.errors.full_messages_for(attribute).join(", ")
      content_tag :p, messages, class: "error-messages-for text-#{alignment}"
    end
  end
end
