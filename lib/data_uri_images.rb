require File.join( File.dirname(__FILE__), 'helpers', 'data_uri_images_form_helper' )
require File.join( File.dirname(__FILE__), 'data_uri_images', 'version' )
require File.join( File.dirname(__FILE__), 'data_uri_images', 'railtie' ) # if defined? ::Rails::Railtie
require File.join( File.dirname(__FILE__), 'data_uri_images', 'engine' )

module DataUriImages #::Insert

  ###
  ### Вынесено в `require`
  ###

  #class Railtie < Rails::Railtie
  #  initializer "DataUriImagesInsert" do
  #    ActionView::Helpers::FormHelper.send(:include, DataUriImages::FormHelper)
  #    ActionView::Base.send(:include, DataUriImages::FormHelper)
  #    ActionView::Helpers::FormBuilder.send(:include, DataUriImages::FormBuilder)
  #  end

	#	config.data_uri_images = ActiveSupport::OrderedOptions.new
 
  #	initializer 'data_uri_images.configure' do |app|
  #  	DataUriImages.configure do |config|
  #    	config.svg          = app.config.data_uri_images[:svg] # :default | :pure
  #    	config.encode       = app.config.data_uri_images[:encode] # ansi | unicode | base64 (default)
  #    	config.force_reload = app.config.data_uri_images[:force_reload] # force reload assets for development
  #  	end

  #	end
  #end

  #class Engine < ::Rails::Engine
  #end
end
