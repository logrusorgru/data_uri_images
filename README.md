# DataUriImages

**Rails** **gem** облегчающий внедрение псевдоизображений - фоновой картинки захэшированной в `data URI`, помещаемый в стили CSS страницы ( приложения ). 

Цель - оптимизация запросов к серверу для маленьких и часто повторяющихся изображений. 

Поддержка - все нормальные браузеры (и `IE9+`).

## Установка


Добавьте эту строку в `Gemfile` приложения:

```ruby

gem 'data_uri_images', :github => 'logrusorgru/data_uri_images'
```


Затем выполните:

    $ bundle


Добавьте строку в стили приложения `app/assets/styleshets/application.css`:

    *= require data_uri_images

<!-- (Or install it yourself as:

    $ gem install data_uri_images) -->

## Использование

##### Необходимые изображения

Необходимые изображения помещаются в папку `app/assets/images/uri`

##### Методы-хелперы

| Хелпер                    |                              Эквивалент |          Итоговый html-тэг |
| :------------------------ | :---------------------------------------|---------------------------:|
| `uri_image`               |                             `image_tag` |                    `<div>` |
| `uri_submit_tag`          |                      `image_submit_tag` | `<input type='image' ...>` |
| `uri_submit`              | `submit type: 'image', src: 'file.png'` | `<input type='image' ...>` |

##### Синтаксис

*haml*

```haml

= helper_metod_name 'uri/image_file.ext', attr_hash
```

`uri/image_file.ext` - путь к файлу изображению *(важно задавать его именно так, а не через* `image_path` *или* `asset_path`*)*. Далее следует стандартный хэш  с атрибутами html-тэга.


##### Примеры

*haml*

```haml

  = uri_image 'uri/logo.png', class: 'img96x96', id: 'logo_id'
```

*html*-выхлоп

```html

    <div class="img96x96 uri uri_logo_png" id="logo_id"></div>
```

*haml*

```haml

= form_tag '/search', method: 'get' do
  = text_field_tag :q
  = uri_submit_tag 'uri/controls/search.png', title: 'Найти'
```

*html*-выхлоп

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

*html*-выхлоп

```html

    ...
    <input class="uri uri_edit_commit_png" type="image"  alt="Commit"
     src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />
```

## CSS классы

Каждому элементу внедрённому с помощью упомянутых выше хелперов добавляются два CSS-класса: `uri` и `uri_path_filename_ ext`. Первый класс один для всех - второй, генерруется для каждого изображения в папке `app/assets/images/uri`

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


## Демо

[**Рабочая демка**](http://data-uri-images-on.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-on)] и для сравнения &mdash; она же &mdash; но [**без использования гема**](http://data-uri-images-off.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-off)]

## IE 6,7,8

* *IE 6,7* &mdash; нет никакой поддержки  
* *IE 8* &mdash; не поддерживается, т.к. браузер не понимает свойство `background-size: contain;`, при использовании фоновой картинки размером с целевой элемент проблем не будет. **Но**, помните, IE8 не поддерживает `data URI` изображения размером больше **32kB**.

*В перспективе поддрежка браузеров IE6,7,8 не планируется. Не хочется утяжилять gem и приложения его использующие. В `master` ветви поддержки этих браузеров не будет. Если Вы хотите расширить возможности гема для поддержки этих браузеров, то только в отдельную ветвь*


## Контрибуция

1. Форкнуть ( http://github.com/logrusorgru/data_uri_images/fork )
2. Создать отдельную ветвь (`git checkout -b my-new-feature`)
3. Сохранить изменения (`git commit -am 'Add some feature'`)
4. Вытолкнуть изменения в новую ветвь (`git push origin my-new-feature`)
5. Создать новый Pull Request

## Лицензия

**MIT**

&copy; 2014 Константин Иванов <ivanov.konstantin@logrus.org.ru>