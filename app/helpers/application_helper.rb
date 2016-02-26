module ApplicationHelper
def bootstrap_class_for flash_type
   { success: "alert-success", error: "alert-danger", alert: "alert-danger", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
 end

 def flash_messages(opts = {})
   flash.each do |msg_type, message|
     concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
         concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
           concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
           concat content_tag(:span, 'Close', class: 'sr-only')
         end)
       concat message
     end)
   end
   nil
 end
end
# Add to config/initializers/form.rb or the end of app/helpers/application_helper.rb
module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "fa fa-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_time, :class => "form-control", :id => "datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "fa fa-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end
