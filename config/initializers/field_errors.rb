MW_FIELD_ERROR_IGNORE_CLASSES = [
  ActionView::Helpers::Tags::Label,
  ActionView::Helpers::Tags::CheckBox,
  ActionView::Helpers::Tags::RadioButton,
]
ActionView::Base.field_error_proc = Proc.new do |tag, instance|
  if MW_FIELD_ERROR_IGNORE_CLASSES.any? { |c| instance.kind_of?(c) }
    tag.html_safe
  else
    attribute = instance.instance_variable_get(:@method_name)
    messages = instance.object.errors.full_messages_for(attribute).join('<br>')

    error_section = <<~"HTML"
      <div class="flex flex-col" data-controller="field-error">
        #{tag}
        <p class="mt-1 error-message" data-field-error-target="message">#{messages}</p>
      </div>
    HTML
    error_section.html_safe
  end
end
