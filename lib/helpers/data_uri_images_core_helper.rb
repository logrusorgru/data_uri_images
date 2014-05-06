#
# data_uri_images_core_helper.rb
#


module DataUriImages

  # хелперы необходимые для функционирования гема
  module CoreHelper

    # доступ к config
    include DataUriImages

    # хелпер для .css ( здесь он для читаемости кода )
    def data_uri_css_is_here
      logger.info "[DtUrImgs]: === START ==="
      logger.info "[DtUrImgs]: @@config.encode is #{@@config.encode}"
      logger.info "[DtUrImgs]: @@config.svg is #{@@config.svg}"
      logger.info "[DtUrImgs]: @@config.prefix is #{@@config.prefix}"
      logger.info "[DtUrImgs]: @@config.minimalize_quotes is #{@@config.minimalize_quotes}"
      logger.info "[DtUrImgs]: @@config.replace_hex_to_rgb is #{@@config.replace_hex_to_rgb}"
      logger.info "[DtUrImgs]: @@config.complete_escape is #{@@config.complete_escape}"
      logger.info "[DtUrImgs]: @@config.apply_for is #{@@config.apply_for}"
      result = ""
      # результаты записываются в result
      # search_path - путь поиска - путь откуда беруться изображения для
      #   добавления их в css
      #   путь должен быть путём ассетов, т.к. используется хелпер asset_data_uri
      search_path = "#{Rails.root}/app/assets/#{@@config.prefix}"
      # все файлы и папки из search_path рекурсивно
      files = Dir.glob "#{search_path}/**/*"
      # цикл по массиву дерева поиска
      files.each do |file|
        # пропуск - если папка
        next if File.directory? file
        # обрезка пути : 
        #   /home/pro/my_app/app/assets/images/uri/subfolder/file.ext
        #   превращается в subfolder/file.ext
        #   в случае если prefix='images/uri'
        asset = Rails.application.assets.find_asset file
        file.gsub! /^#{search_path}\//, ""
        # Замена точек и '/' на '_'
        result += "/* File: #{file} */\n"
        # Проверка на доп-стили
        if @@config.apply_for.include? file
          result += "#{apply_for[file]}, "
        end
        # Замена точек и '/' на '_'
        result += ".#{file.gsub(/\./, "_").gsub(/\//, "_")}"
        # генерация свойства CSS 'background-image'
        result += " { background-image: url( \""
        #
        #
        #
        logger.info "[DtUrImgs]: asset ct is #{asset.content_type}"
        logger.info "[DtUrImgs]: file is #{file}"
        if asset.content_type == "image/svg+xml" && @@config.svg == :pure
          # чистогановый SVG
          result += encode_to_data_uri asset, :pure
          logger.info "[DtUrImgs]: asset pure encoding"
        else
          result += encode_to_data_uri asset, @@config.encode
          logger.info "[DtUrImgs]: asset encode by #{@@config.encode}"
        end
        # добавление директивы !important на всякий случай
        result += "\" ) !important; } \n"
      end
      logger.info "[DtUrImgs]: === DONE ==="
      result
    end

    protected
      # преобразует цвета в формате hex в формат rgb
      # #fff => rgb(255,255,255)
      def hex_to_rgb input
        #> hex_to_rgb "#fff"       #=> "rgb(255,255,255)"
        #> hex_to_rgb "#ffccff"    #=> "rgb(255,204,255)"
        hex = /[a-f0-9]{1,2}/i
        a = ( input.match /#(#{hex})(#{hex})(#{hex})/ )[1..3]
        a.map!{ |x| x + x } if input.size == 4
        "rgb(#{a[0].hex},#{a[1].hex},#{a[2].hex})"
      end

      # в общем виде url для 'чиcтых'' svg выглядит так
      #   ...: url("data:image/svg+xml,<svg...</svg>") !important;
      # при этом все " заменяются на \"
      # этот метод заменяет двойные кавычки на одинарные,
      #  если при этом результирующий файл будет меньше ( с учётом \ )
      def minimalize_quotes str
        dq = str.count("\"")
        uq = str.count("'")
        return str if dq == 0
        return str.gsub(/\"/,"'") if uq == 0
        if dq > 2*uq
          str.gsub(/\'/,'\"').gsub(/([^\\])\"/,'\1\'')
        else
          str.gsub(/\"/,'\"')
        end
      end

      def encode_to_data_uri asset, method = :base64
        "data:#{asset.content_type}".concat case method
        when :acsii
          @@config.complete_escape ?
            ",#{ Rack::Utils.escape( asset.to_s ) }" :
            ",#{ URI.escape( asset.to_s ) }"
        when :pure
          @@config.complete_escape ?
            ",#{Rack::Utils.escape( purify asset.to_s ) }" :
            ",#{ purify asset.to_s }"
        else # :base64
          ";base64," + unless @@config.complete_escape
            "#{ Base64.strict_encode64( asset.to_s ) }"
          else
            "#{ Rack::Utils.escape( Base64.strict_encode64( asset.to_s ) ) }"
          end
        end
      end

      def purify asset
        #logger.info "[DtUrImgs]: purify input. asset is #{asset}"                    # low lvl dbg
        asset = minimalize_quotes asset if @@config.minimalize_quotes
        #logger.info "[DtUrImgs]: purify min minimalize_quotes. asset is #{asset}"    # low lvl dbg
        asset.gsub!( /#[a-f0-9]{3,6}/i ) { |h|  hex_to_rgb h } if @@config.replace_hex_to_rgb
        #logger.info "[DtUrImgs]: purify replace_hex_to_rgb. asset is #{asset}"       # low lvl dbg
        asset.gsub /\"/, '\"'
      end

    # end of CoreHelper
  end
end