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
        ### теперь конфиг несколько расширен
        # svg       : [ :pure, :ascii, some outher ]
        #   default - по умолчанию тот же метод кодирования,
        #             что и для остальных файлов
        #   :pure - вставляется читый svg   
        #   :ascii - кодируется в url ( URI.escape( str ) )
        # prefix    : [ path, nil ]
        #   папка для поиска, внутри дирректория ассетов
        #     кароче приписывается к имени файла - и передаётся в asset_path
        #   default = uri/
        #   В итоге изображения будут браться из папки root_path/prefix
        #     по умолчанию это "#{Rails.root}/app/assets/images/uri"
        # encode    : [ :base64, :ascii ]
        # :minimalize_quotes = true/false
        #   минимизация кавычек - идёт замена двойных на одинарные, если от
        #   этого итоговая строка будет меньше. Имеет смысл только при
        #   svg = :pure, т.к. при этом символ " экранируется \"
        # :replace_hex_to_rgb = true/false
        #   аналогично нужен только при svg = :pure
        #   дабы не было проблем с '#' в итоговой строке подменяет все(!)
        #   значения типа #fff, #098af3 на типа rgb(234,25,254)
        # complete_escape - полное экранирование спецсимволов,
        #   по дефолту в тру, строка перед выхлопом проходит через
        #   Rack::Urils.escape и при этом раздувается нереально,
        #   учитывайте, что браузеры хавают одинаково - полностью экранированные
        #   полностью не экранированные URI (по крайней мере в base64).
        #   Не хотите распухания - ставьте в false.
        #   Протестированно на последних версиях для Linux
        #     Chrome 34
        #     FF     28
        #     Opera  12
        #     Midiri
        #     Konqueror
        config.svg                = app.config.data_uri_images[:svg] || nil
        config.encode             = app.config.data_uri_images[:encode] || :base64
        config.prefix             =
                app.config.data_uri_images[:prefix] || "images/uri"
        config.minimalize_quotes  =
                app.config.data_uri_images[:minimalize_quotes] || false
        config.replace_hex_to_rgb =
                app.config.data_uri_images[:replace_hex_to_rgb] || false
        config.complete_escape    =
                app.config.data_uri_images[:complete_escape] || false
        config.apply_for          = app.config.data_uri_images[:apply_for] || {}
    	end

  	end
  end

end
