module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map{ |msg| "<p>#{msg}.</p>"}.join

    html = <<-HTML
    <div class="alert alert-danger" id="error_explanation">      
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
