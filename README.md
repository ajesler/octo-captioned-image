# Octopress Captioned Image

An Octopress ink plugin for creating captioned images.

[![Gem Version](https://badge.fury.io/rb/octo-captioned-image.svg)](http://badge.fury.io/rb/octo-captioned-image) [![Build Status](https://travis-ci.org/ajesler/octo-captioned-image.svg?branch=master)](https://travis-ci.org/ajesler/octo-captioned-image) 

## Example

![Example Usage](https://github.com/ajesler/octo-captioned-image/raw/master/captioned-image-example.png)

is produced by 

```
{% captioned_image /images/kitten.jpeg "a kitten!" float:"left" chrome %}
{% captioned_image /images/ijen-fire.jpg "Fire on Mt Ijen by Dennis Stauffer via Flickr" float:"left" position:"bottom" chrome %}
```

## Installation

If you're using bundler add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octo-captioned-image'
    end

Then install the gem with Bundler

    $ bundle

To install manually without bundler:

    $ gem install octo-captioned-image

Then add the gem to your Jekyll configuration.

    gems:
      - octo-captioned-image

If you're using a standard Jekyll theme, add `{% css_asset_tag %}` to your site layout.  


## Syntax

```
{% captioned_image src caption [width height] [position:top|bottom] [float:left|right] [clear:left|right|both] %}
```

### Properties

`src` and `caption` are required, the rest of the properties are optional.  
Please note that both width and height must be given or neither given. `auto` can be used as a width and height value.

* `src`  
this is required and can be an absolute or relative path.
* `caption`  
this is required and must be surrounded by `"` or `'`. Any usages of the surrounding quote type (`"` or `'`) in the caption must be escaped like `\"` or `\'`. If you surrounded the caption with `"` then `'` in the caption do not need to be escaped, and vice versa.
* `width`  
no default value
* `height`  
no default value
* `float`  
no default value
* `clear`  
no default value
* `position`  
defaults to `top`  
* `chrome`  
has no value, but if present will add a gradient background to the caption.


## Examples

```
{% captioned_image {{site.url}}/images/puppies.png "Look at the puppies!" %}

{% captioned_image {{site.url}}/images/adventure_awaits.gif "Adventure awaits!" float:"left" clear:"right" %}

{% captioned_image {{site.url}}/images/sad_robot.png "This is why we dont let machines have feelings" 1000px 500px position:bottom float:"left" clear:"right" chrome %}

{% captioned_image {{site.url}}/images/unimportant.jpg "And I said \"O'Leary is a fun guy!\"" clear:"both" position:"bottom" %}

// you can also embed html into the caption
// note that you will be need to careful with the html quotes.
{% captioned_image {{site.url}}/images/circuit-schematic.png "Circuit schematic - created with <a href='https://fritzing.org'>fritzing</a>" %}

// multiple images in a figure
// note that all the images will have the same caption, and that any size given will be applied to all images
{% captioned_image {{site.url}}/images/a-mouse.png {{site.url}}/images/a-bear.png "How to spot the difference between bears and mice" position:"bottom" chrome %}
```

results in the following html

```html
<figure class="captioned-image">
	<figcaption class="caption-top">
		Look at the puppies!
	</figcaption>
	<img src="http://yoursite.com/images/puppies.png" alt="Look at the puppies!">
</figure>

<figure class="captioned-image float-left clear-right">
	<figcaption class="caption-top">
		Adventure awaits!
	</figcaption>
	<img src="http://yoursite.com/images/adventure_awaits.gif" alt="Adventure awaits!">
</figure>

<figure class="captioned-image-chrome float-left clear-right">
	<img src="http://yoursite.com/images/sad_robot.png" alt="This is why we dont let machines have feelings" width="1000px" height="500px">
	<figcaption class="caption-bottom-chrome">
		This is why we dont let machines have feelings
	</figcaption>
</figure>

<figure class="captioned-image clear-both">
	<img src="http://yoursite.com/images/unimportant.jpg" alt="And I said &quot;O'Leary is a fun guy!&quot;" width="1000px" height="500px">
	<figcaption class="caption-bottom">
		And I said &quot;O'Leary is a fun guy!&quot;
	</figcaption>
</figure>

<figure class="captioned-image">
  <figcaption class="caption-top">
    Circuit schematic - created with <a href='http://fritzing.org'>fritzing</a>
  </figcaption>
  <img src="http://yoursite.com/images/circuit-schematic.png" alt="Circuit schematic - created with <a href='http://fritzing.org'>fritzing</a>" />
</figure>

<figure class="captioned-image-chrome">
  <img src="http://yoursite.com/images/a-mouse.png" alt="How to spot the difference between bears and mice" />
  <img src="http://yoursite.com/images/a-bear.png" alt="How to spot the difference between bears and mice" />
  <figcaption class="caption-bottom-chrome">
    How to spot the difference between bears and mice
  </figcaption>
</figure>
```

## Customisation

To customise the styling, copy the stylesheet into your _plugins directory with the following command. You can then edit it and override the default styles.

```
octopress ink copy octo-captioned-image --stylesheets
```

## Testing

There are two sets of tests; caption extraction/option parsing logic, and a rendered output check.

```
rake test
bundle exec clash test
```

## Contributing

1. Fork it ( https://github.com/ajesler/octo-captioned-image/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
