# data_uri_images_form_helper.rb

module DataUriImages
  module FormHelper
  	def uri_image image_file, options = {}
  	  options[:class] ||= "" #  if options[:class].blank?
  	  options[:class] += " uri " + image_file.gsub(/\./, "_").gsub(/\//, "_")
  	  middle = ""
  	  options.each{ |k,v| middle += "#{k}='#{v.strip}' "}
  	  "<div #{middle}></div>".html_safe
  	end

  	# ещё один хелпер - замена image_submit_tag, remake - по ссылке:
  	# http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-	image_submit_tag
  	def uri_submit_tag image_file, options = {}
  	  # прозрачное однопиксельное gif изображение
  	  blank_gif = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
  	  #
  	  options[:class] ||= "" #  if options[:class].blank?
  	  options[:class] += " uri " + image_file.gsub(/\./, "_").gsub(/\//, "_")
  	  options[:class].strip!
  	  options = options.stringify_keys

  	  if confirm = options.delete("confirm")
  	    message = ":confirm option is deprecated and will be removed from Rails 4.1. "	                      "Use 'data: { confirm: \'Text\' }' instead'."
  	    ActiveSupport::Deprecation.warn message
  	    options["data-confirm"] = confirm
  	  end

  	  tag :input, { "alt" => image_alt(image_file), "type" => "image", "src" => blank_gif }.update(	options)
  	end
  end
end


module DataUriImages::FormBuilder
	def uri_submit image_file, options = {}
		@template.uri_submit_tag( image_file, options )
	end
end
