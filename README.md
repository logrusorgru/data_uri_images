# DataUriImages

**Rails** **gem** облегчающий внедрение псевдоизображений - фоновой картинки захэшированной в `data URI`, помещаемый в стили CSS страницы ( приложения ). 

Цель - оптимизация запросов к серверу для маленьких и часто повторяющихся изображений. 

Поддержка - все нормальные браузеры (и `IE9+`).

## Версия

Текущая версия `0.1.0` для использования старых версий используйте следующие строки в `Gemfile`

Для версии `0.0.1`

```ruby
gem 'data_uri_images', :github => 'logrusorgru/data_uri_images', :tag => 'v0.0.1'
```
Для версии `0.0.2`

```ruby
gem 'data_uri_images', :github => 'logrusorgru/data_uri_images', :tag => 'v0.0.2'
```

## Добавлено:

* Возможность добавлять свои селекторы по файлу [`apply_for`](#apply_for)

* Добавлена возможность выбирать дирркторий для поиска [`prefix`](#prefix)

* Добавлена возможность кодировать не только в [`base64`](#encode) но и в [`ACSII`](#encode)

* Добавлена возможность полной маскировки спецсимволов [(на выбор)](#complete_escape)

* Опции предварительной обработки `SVG` изображений ([1](#replace_hex_to_rgb)|[2](#minimalize_quotes))

* Возможность не кодировать `SVG` файлы, а использовать их чистыми [`svg`](#svg)

## Настройки

Все настройки включаются в файле `app/config/application.rb`, например так

```ruby
# app/config/application.rb
# ...
  class Application < Rails::Application
    # ...
    config.data_uri_images.svg = :pure
  end
# ...
```
Возможные настройки

<dl>
  <dt><a name='svg'></a>svg</dt>
  <dd>Установите значение в <code>:pure</code> если хотите не кодировать <code>SVG</code>-файлы,
      любое другое значение будет кодировать их по методу <code>encode</code> - это значение по умолчанию.
      Пример "чиcтого" <code>svg</code>
<div class="highlight highlight-svg"><pre>
data:image/svg+xml,&lt;svg height='200' width='200' xmlns='http://www.w3.org/2000/svg'&gt;&lt;text x="15" y="15" fill="red" transform="rotate(30 20,40)"&gt;I love SVG&lt;/text&gt;&lt;/svg&gt;
</pre></div>
Вобще говоря - <code>SVG</code> с текстом (как в примере выше), мало где отображаются корректно, однако Вы можете скопировать эту строку в адресную строку браузера и взглянуть. Идея навеяна вот от <a href="http://r.va.gg/2012/05/data-uri-svg.html">сюда</a>, а вот тематический <a href="http://jsfiddle.net/rvagg/exULa/">fiddle</a>.</dd>
  <dt><a name="prefix"></a>prefix</dt>
  <dd>Дирректорий для поиска, по умолчанию <code>images/uri</code>. Вы можете указать любой другой,
      но это должен быть один из дирректориев ассетов</dd>
  <dt><a name="encode"></a>encode</dt>
  <dd>Метод кодиования - по умолчанию это <code>base64</code>, можно установить в <code>:acsii</code></dd>
  <dt><a name="minimalize_quotes"></a>minimalize_quotes</dt>
  <dd>Эта опция для актуально только для не кодированных <code>SVG</code>-файлов. По умолчанию установлен в
      <code>false</code>, при установке в <code>true</code> во всех <code>SVG</code>-файлах будет проведена оптимизация количества кавычек.
      Суть в том, что в <code>css</code>-файле это выглядит примерно так
<div><pre>
.u0_svg{
  background-image: url("data:image/svg+xml,&lt;svg xmlns=...&gt;&lt;path fill=\"#000\"&gt; ... &lt;/svg&gt;") !important;
}
</pre></div>
      т.е. двойные кавычки маскируются слэшем <code>'\"'</code>. При оптимизации двойные кавычки будут заменены на одинарные,
      если итоговы размер от этого уменьшится.
      </dd>
  <dt><a name="replace_hex_to_rgb"></a>replace_hex_to_rgb</dt>
  <dd>Актуально для чистого (не кодированного) <code>SVG</code> - замена цветов <code>hex</code> на <code>rgb()</code> - имеет смысл в Opera и FF например, т.к. у них проблемы с восприятием неэкранированной решётки <code>#</code>. Переход на <code>rgb()</code> её решает.</dd>
  <dt><a name="complete_escape"></a>complete_escape</dt>
  <dd>Полное экранирование. По умолчанию <code>false</code>. При установке в <code>true</code> Ваш <code>css</code> станет полностью валидным, но от этого серьёзно возрастает размер файла. Кроме того - использование опции <code>.svg = :pure</code> в паре с этой опцией (установленной в <code>true</code>) приведёт краху =). Используйте эту опцию только для <code>base64</code>-кодированных изображений - или не используйте вовсе.</dd>
   <dt><a name="apply_for"></a>apply_for</dt>
   <dd>Это хэш, позволяет добавить собственный селектор по имени файла (пути к файлу и имении, если быть точным). Например, если есть желание
   к изображению <code>target_blank.svg</code> применить селектор <code>a[href^="http"]</code> - то хэш будет
   таким
<pre>
config.data_uri_images.apply_for = { 'target_blank.svg' => 'a[href^="http"]' }
</pre>
в стилях это будет выглядеть так
<pre>
a[href^="http"], .target_blank_svg{
  background-image: url(......
}
</pre>
   </dd>
</dl>


## Установка


Добавьте эту строку в `Gemfile` приложения:

```ruby

gem 'data_uri_images', :github => 'logrusorgru/data_uri_images'
```


Затем выполните:

    $ bundle


Добавьте строку в стили приложения `app/assets/styleshets/application.css`:

```css
*= require data_uri_images
```

Если Вы пользуетесь `SASS` или `SCSS` - то можете вместо этого (строки выше) использовать диррективу `@import` вот так:

```scss
@import 'data_uri_images/data_uri_images';
```

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

= helper_metod_name 'image_file.ext', attr_hash
```

`image_file.ext` - путь к файлу изображению *(важно задавать его именно так, а не через* `image_path` *или* `asset_path`*)*. Далее следует стандартный хэш  с атрибутами html-тэга.


##### Примеры

*haml*

```haml

  = uri_image 'logo.png', class: 'img96x96', id: 'logo_id'
```

*html*-выхлоп

```html

    <div class="img96x96 uri logo_png" id="logo_id"></div>
```

*haml*

```haml

= form_tag '/search', method: 'get' do
  = text_field_tag :q
  = uri_submit_tag 'controls/search.png', title: 'Найти'
```

*html*-выхлоп

```html

...
<input class="uri controls_search_png" type="image"  alt="Search"
 src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />
```

*haml*

```haml

= form_for @post do |f|
  = f.text_field :content, required: true
  = f.uri_submit 'edit/commit.png'
```

*html*-выхлоп

```html

...
<input class="uri edit_commit_png" type="image"  alt="Commit"
 src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />
```

## CSS классы

Каждому элементу внедрённому с помощью упомянутых выше хелперов добавляются два CSS-класса: `uri` и `path_filename_ext`. Первый класс один для всех - второй, генерруется для каждого изображения в папке `app/assets/images/uri`

```css

.uri{
  background-size: contain !important;
  background-repeat: no-repeat !important;
}

/* пример для файла app/assets/images/uri/edit/commit.png */
.edit_commit_png{
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
  margin: .5em;
}
```

Каждый элемент `<input type=image>` внедрённый хелперами `uri_submit_tag` и `uri_submit` &mdash; по сути прозрачное изображение с фоновой картинкой. Аттрибут `src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="` &mdash; это однопиксельный прозрачный `GIF`.


## Демо

* [**Рабочая демка**](http://data-uri-images-on.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-on)]
* Она же &mdash; но [**без использования гема**](http://data-uri-images-off.herokuapp.com/)&nbsp;[[source](https://github.com/logrusorgru/data-uri-images-off)]

## IE 6,7,8

* *IE 6,7* &mdash; нет никакой поддержки  
* *IE 8* &mdash; не поддерживается, т.к. браузер не понимает свойство `background-size: contain;`, при использовании фоновой картинки размером с целевой элемент проблем не будет. **Но**, помните, IE8 не поддерживает `data URI` изображения размером больше **32kB**.

*В перспективе поддрежка браузеров IE6,7,8 не планируется. Не хочется утяжилять gem и приложения его использующие. В `master` ветви поддержки этих браузеров не будет. Если Вы хотите расширить возможности гема для поддержки этих браузеров, то только в отдельную ветвь*

## TODO

* Сделать возвожным автоматическую перезагрузку файла - при изменении в дирректории `app/assets/images/uri`. На текущий момент приходиться возиться вплоть до удаления `app/tmp/cache/assets` =) 
Ожидайте в новых версиях.

## Контрибуция

1. Форкнуть ( http://github.com/logrusorgru/data_uri_images/fork )
2. Создать отдельную ветвь (`git checkout -b my-new-feature`)
3. Сохранить изменения (`git commit -am 'Add some feature'`)
4. Вытолкнуть изменения в новую ветвь (`git push origin my-new-feature`)
5. Создать новый Pull Request

## Лицензия

**MIT**

&copy; 2014 Константин Иванов <ivanov.konstantin@logrus.org.ru>
