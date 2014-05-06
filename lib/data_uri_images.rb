require File.join( File.dirname(__FILE__), 'helpers', 'data_uri_images_form_helper' )
require File.join( File.dirname(__FILE__), 'helpers', 'data_uri_images_core_helper' )
require File.join( File.dirname(__FILE__), 'data_uri_images', 'version' )
require File.join( File.dirname(__FILE__), 'data_uri_images', 'railtie' ) # if defined? ::Rails::Railtie
require File.join( File.dirname(__FILE__), 'data_uri_images', 'engine' )

module DataUriImages #::Insert
  # конфиги
  class Config
    attr_accessor :svg, :prefix, :encode, :minimalize_quotes,
                  :replace_hex_to_rgb, :complete_escape, :apply_for
    # svg       : [ nil, :pure, :ascii ]
    #   default - nil ( the same )
    # prefix    : [ nil, path ]
    #   default = /app/assets/images/uri/
    # encode    : [ :default, :base64 = nil, :ascii ]
    #   default = base64
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end

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
