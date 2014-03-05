require File.join( File.dirname(__FILE__), 'data_uri_images', 'version' )
require File.join( File.dirname(__FILE__), 'app', 'helpers', 'data_uri_images_form_helper' )

module DataUriImages::Insert
  class Railtie < Rails::Railtie
    initializer "DataUriImagesInsert" do
      ActionView::Helpers::FormHelper.send(:include, DataUriImages::FormHelper)
      ActionView::Base.send(:include, DataUriImages::FormHelper)
      ActionView::Helpers::FormBuilder.send(:include, DataUriImages::FormBuilder)
    end
  end
end
