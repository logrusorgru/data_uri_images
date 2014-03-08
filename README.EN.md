# DataUriImages

**Rails** **gem** облегчающий внедрение псевдоизображений - фоновой картинки захэшированной в `data URI`, помещаемый в стили CSS страницы ( приложения ). 

Цель - оптимизация запросов к серверу для маленьких и часто повторяющихся изображений. 

Support - all major browsers (and `IE9+`).

## Installation

Add this line to your application's Gemfile:

```ruby

gem 'data_uri_images', :github => 'logrusorgru/data_uri_images'
```

And then execute:

    $ bundle

Append string to `app/assets/styleshets/application.css`:

    *= require data_uri_images

<!-- (Or install it yourself as:

    $ gem install data_uri_images) -->

## Usage

##### Necessary images

Put necessary images into `app/assets/images/uri` folder

##### Helper-methods

| Helper                    |                              Equivalent |             Final html-tag |
| :------------------------ | :---------------------------------------|---------------------------:|
| `uri_image`               |                             `image_tag` |                    `<div>` |
| `uri_submit_tag`          |                      `image_submit_tag` | `<input type='image' ...>` |
| `uri_submit`              | `submit type: 'image', src: 'file.png'` | `<input type='image' ...>` |

##### Syntax

*haml*

```haml

= helper_metod_name 'uri/image_file.ext', attr_hash
```

`uri/image_file.ext` - path to image file *(not use* `image_path` *or* `asset_path`*)*. Далее следует стандартный хэш  с атрибутами html-тэга.


##### Examples

*haml*

```haml

  = uri_image 'uri/logo.png', class: 'img96x96', id: 'logo_id'
```

*html*-exhaust

```html

    <div class="img96x96 uri uri_logo_png" id="logo_id"></div>
```

*haml*

```haml

= form_tag '/search', method: 'get' do
  = text_field_tag :q
  = uri_submit_tag 'uri/controls/search.png', title: 'Найти'
```

*html*-exhaust

```html

...
<input class="uri uri_controls_search_png" type="image"  alt="Search"
 src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />
```

*haml*

```haml

= form_for @post do |f|
  = f.text_field :content, required: true
  = f.uri_submit 'uri/edit/commit.png'
```

*html*-exhaust

```html

...
<input class="uri uri_edit_commit_png" type="image"  alt="Commit"
 src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />
```

## CSS classes

Каждому элементу внедрённому с помощью упомянутых выше хелперов добавляются два CSS-класса: `uri` и `uri_path_filename_ext`. Первый класс один для всех - второй, генерруется для каждого изображения в папке `app/assets/images/uri`

```css

.uri{
  background-size: contain !important;
  background-repeat: no-repeat !important;
}

/* пример для файла app/assets/images/uri/edit/commit.png */
.uri_edit_commit_png{
  background-image: url(data:image/png;base64,*** data uri хэш ***) !important;
}
```

**Важно** - элементы `div` не имеют ширины и высоты по-умолчанию. Поэтому не забудьте добавить им (или классу `uri`) необходимые размеры, иначе элементы внедрённые хелпером `uri_image` не будут видны на странице. Кроме того они не будут вести себя как изображения - необходимо добавить отсупы и обтекания, если нужно.

*Пример расширенного класса `uri`*

```css

.uri{
  height: 3em;
  width: 3em;
  float: left;
  padding: .5em;
}
```

Каждый элемент `<input type=image>` внедрённый хелперами `uri_submit_tag` и `uri_submit` &mdash; по сути прозрачное изображение с фоновой картинкой. Аттрибут `src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="` &mdash; это однопиксельный прозрачный `GIF`.


## Demo

[**Work demo**](http://data-uri-images-on.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-on)] and &mdash; [**demo without gem**](http://data-uri-images-off.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-off)] for comparison.

## IE 6,7,8

* *IE 6,7* &mdash; not support  
* *IE 8* &mdash; not support, т.к. браузер не понимает свойство `background-size: contain;`, при использовании фоновой картинки размером с целевой элемент проблем не будет. **Но**, помните, IE8 не поддерживает `data URI` изображения размером больше **32kB**.

*В перспективе поддрежка браузеров IE6,7,8 не планируется. Не хочется утяжилять gem и приложения его использующие. В `master` ветви поддержки этих браузеров не будет. Если Вы хотите расширить возможности гема для поддержки этих браузеров, то только в отдельную ветвь*


## Contributing

1. Fork it ( http://github.com/<my-github-username>/data_uri_images/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

**MIT**

&copy; 2014 Konstantin Ivanov <ivanov.konstantin@logrus.org.ru>
