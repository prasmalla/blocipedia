module ApplicationHelper
  # devise for other controllers
  def resource_name
    @resource_name ||= admin_controller? ? :admin_user : :user
  end

  def resource
    @resource ||= resource_name.to_s.classify.constantize.new
  end

  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[resource_name]
  end

  def admin_controller?
    !devise_controller? && request.path =~ /^\/admin/
  end

  def bootstrap_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <h5>#{sentence}</h5>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def bootstrap_flash(flash)
    return if flash.empty?
    
    key = flash.keys.first
    type = case key
    when "notice"; "success"
    when "error"; "danger"
    else "warning"
    end

    html = <<-HTML
    <div class="alert alert-#{type}">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      #{flash[:"#{key}"]}
    </div>
    HTML

    html.html_safe
  end
end
