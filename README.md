# Octopress Captioned Image

Creates captioned images.

## Example

![Example Usage](https://github.com/ajesler/octopress-captioned-image/raw/master/captioned-image-example.png)

is produced by 

```
{% captioned_image /images/kitten.jpeg "a kitten!" float:"left" %}
{% captioned_image /images/ijen-fire.jpg "Fire on Mt Ijen by Dennis Stauffer via Flickr" float:"left" position:"bottom" %}
```

## Installation

If you're using bundler add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-captioned-image'
    end

Then install the gem with Bundler

    $ bundle

To install manually without bundler:

    $ gem install octopress-captioned-image

Then add the gem to your Jekyll configuration.

    gems:
      - octopress-captioned-image

If you're using a standard Jekyll theme, add {% css_asset_tag %} to your site layout.

## Syntax

```
{% captioned_image src caption [width height] [position:top|bottom] [float:left|right] [clear:left|right|both] %}
```

### Properties

`src` and `caption` are required, the rest of the properties are optional.

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


## Examples

```
{% captioned_image {{site.url}}/images/puppies.png "Look at the puppies!" %}

{% captioned_image {{site.url}}/images/adventure_awaits.gif "Adventure awaits!" float:"left" clear:"right" %}

{% captioned_image {{site.url}}/images/sad_robot.png "This is why we dont let machines have feelings" 1000px 500px position:bottom float:"left" clear:"right" %}

{% captioned_image {{site.url}}/images/unimportant.jpg "And I said \"O'Leary is a fun guy!\"" clear:"both" position:"bottom" %}
```

results in the following html

```
<figure class="captioned-image-figure">
	<figcaption class="captioned-image-caption-top">
		Look at the puppies!
	</figcaption>
	<img src="http://yoursite.com/images/puppies.png" alt="Look at the puppies!">
</figure>

<figure class="captioned-image-figure.float-left.clear-right">
	<figcaption class="captioned-image-caption-top">
		Adventure awaits!
	</figcaption>
	<img src="http://yoursite.com/images/adventure_awaits.gif" alt="Adventure awaits!">
</figure>

<figure class="captioned-image-figure.float-left.clear-right">
	<img src="http://yoursite.com/images/sad_robot.png" alt="This is why we dont let machines have feelings" width="1000px" height="500px">
	<figcaption class="captioned-image-caption-bottom">
		This is why we dont let machines have feelings
	</figcaption>
</figure>

<figure class="captioned-image-figure.clear-both">
	<img src="http://yoursite.com/images/unimportant.jpg" alt="And I said &quot;O'Leary is a fun guy!&quot;" width="1000px" height="500px">
	<figcaption class="captioned-image-caption-bottom">
		And I said &quot;O'Leary is a fun guy!&quot;
	</figcaption>
</figure>
```

## Customisation

If you want to modify any of the CSS classes, see [main.scss](https://github.com/ajesler/octopress-captioned-image/blob/master/assets/stylesheets/main.scss).

## Testing

There are two sets of tests, one for the caption extractor and one full integration test with octopress-ink.

```
bundle exec clash test
rake test
```

## Contributing

1. Fork it ( https://github.com/ajesler/octopress-captioned-image/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request