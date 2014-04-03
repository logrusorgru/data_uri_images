# coding: utf-8

####
##   railtie.rb
###
#

module DataUriImages::Insert

	# расширение хелпера форм и formbilder
  class Railtie < Rails::Railtie
    initializer "DataUriImagesInsert" do
      ActionView::Helpers::FormHelper.send(:include, DataUriImages::FormHelper)
      ActionView::Base.send(:include, DataUriImages::FormHelper)
      ActionView::Helpers::FormBuilder.send(:include, DataUriImages::FormBuilder)
    end

    # настройки
		config.data_uri_images = ActiveSupport::OrderedOptions.new

  	initializer 'data_uri_images.configure' do |app|
    	DataUriImages.configure do |config|
        # опция позволяет не кодировать SVG изображения а вставлять их чистыми -
        # как они есть, например вот URI:
        # data:image/svg+xml,<svg height='200' width='200' xmlns='http://www.w3.org/2000/svg'><text x="15" y="15" fill="red" transform="rotate(30 20,40)">I love SVG</text></svg>
        # :default - base64
        # :pure    - чистоганом ( c экранированием \"  и \\ )
      	config.svg          = app.config.data_uri_images[:svg] || :default
      	#config.encode       = app.config.data_uri_images[:encode] # ansi | base64 (default)
    	end

  	end
  end

end
