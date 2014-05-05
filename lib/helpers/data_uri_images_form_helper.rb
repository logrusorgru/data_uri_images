# data_uri_images_form_helper.rb

module DataUriImages

  # расширение хелпера форм
  module FormHelper

    # простое изображение
    def uri_image image_file, options = {}
      options[:class] ||= "" #  if options[:class].blank?
      options[:class] += " uri " + image_file.gsub(/\./, "_").gsub(/\//, "_")
      middle = ""
      options.each{ |k,v| middle += "#{k}='#{v.strip}' " }
      "<div #{middle}></div>".html_safe
    end

    # ещё один хелпер - замена image_submit_tag, remake - по ссылке:
    # http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-image_submit_tag
    def uri_submit_tag image_file, options = {}
      # прозрачное однопиксельное gif изображение
      # На просторах сети встречались и более коротки GIF - однако они не
      # корректно вели себя - отказывались отображаться в Opera, былы чёрными в
      # FF
      blank_body = "R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
      blank_gif = "data:image/gif;base64,".concat config.complite_escape ?
          Rack::Utils.escape( blank_body ) : blank_body
      #
      options[:class] ||= "" #  if options[:class].blank?
      # добавляем класс 'uri' и класс соответствующий изображению
      options[:class] += " uri " + image_file.gsub(/\./, "_").gsub(/\//, "_")
      # обрезка лишних пробелов по краям
      options[:class].strip!
      # преобразует ключи - символы в строки:
      # :class -> "class" ( Symbol -> String )
      options = options.stringify_keys

      # Логи для устаревшего использования опции 'confirm'
      # Не забыть удалить для будующих версий, для будующих версий Rails. Ах-ха.
      if confirm = options.delete("confirm")
        message = 
            ":confirm option is deprecated and will be removed from Rails 4.1. "
            "Use 'data: { confirm: \'Text\' }' instead'."
        ActiveSupport::Deprecation.warn message
        options["data-confirm"] = confirm
      end

      tag :input, { "alt" => image_alt(image_file),
                                 "type" => "image",
                                 "src" => blank_gif }.update( options )
    end
  end
end

# Для form_for и fields_for
# Расширение стандартного FormBuilder позволит использовать и расширять его. 
# Например если Вы захотите в своём приложении использовать свой FormBuilder
# - все фишки текущего в нём уже будут ( а не отвалятся ).
module DataUriImages::FormBuilder
  def uri_submit image_file, options = {}
    @template.uri_submit_tag( image_file, options )
  end
end
