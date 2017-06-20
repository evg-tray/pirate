module ErrorsHelper
  def error_messages(res)
    return "" if res.errors.empty?

    messages = res.errors.full_messages.map{ |msg| "<p>#{msg}.</p>"}.join

    html = <<-HTML
    <div class="alert alert-danger" id="error_explanation">      
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
