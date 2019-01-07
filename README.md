# Jets Html Sanitizers

This is a fork of rails-html-sanitizer.  This is done so we can keep the namespace under `Jets` to avoid naming collisions with `Jets`. Credit for original work goes to the [rails-html-sanitizer](https://github.com/rails/rails-html-sanitizer) authors.

In Jets this gem will be responsible for sanitizing HTML fragments in Jets
applications, i.e. in the `sanitize`, `sanitize_css`, `strip_tags` and `strip_links` methods.

Jets Html Sanitizer is only intended to be used with Jets applications. If you need similar functionality in non Jets apps consider using [Loofah](https://github.com/flavorjones/loofah) directly (that's what handles sanitization under the hood).

## Installation

Add this line to your application's Gemfile:

    gem 'jets-html-sanitizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jets-html-sanitizer

## Usage

### Sanitizers

All sanitizers respond to `sanitize`.

#### FullSanitizer

```ruby
full_sanitizer = Jets::Html::FullSanitizer.new
full_sanitizer.sanitize("<b>Bold</b> no more!  <a href='more.html'>See more here</a>...")
# => Bold no more!  See more here...
```

#### LinkSanitizer

```ruby
link_sanitizer = Jets::Html::LinkSanitizer.new
link_sanitizer.sanitize('<a href="example.com">Only the link text will be kept.</a>')
# => Only the link text will be kept.
```

#### WhiteListSanitizer

```ruby
white_list_sanitizer = Jets::Html::WhiteListSanitizer.new

# sanitize via an extensive white list of allowed elements
white_list_sanitizer.sanitize(@article.body)

# white list only the supplied tags and attributes
white_list_sanitizer.sanitize(@article.body, tags: %w(table tr td), attributes: %w(id class style))

# white list via a custom scrubber
white_list_sanitizer.sanitize(@article.body, scrubber: ArticleScrubber.new)

# white list sanitizer can also sanitize css
white_list_sanitizer.sanitize_css('background-color: #000;')
```

### Scrubbers

Scrubbers are objects responsible for removing nodes or attributes you don't want in your HTML document.

This gem includes two scrubbers `Jets::Html::PermitScrubber` and `Jets::Html::TargetScrubber`.

#### `Jets::Html::PermitScrubber`

This scrubber allows you to permit only the tags and attributes you want.

```ruby
scrubber = Jets::Html::PermitScrubber.new
scrubber.tags = ['a']

html_fragment = Loofah.fragment('<a><img/ ></a>')
html_fragment.scrub!(scrubber)
html_fragment.to_s # => "<a></a>"
```

#### `Jets::Html::TargetScrubber`

Where `PermitScrubber` picks out tags and attributes to permit in sanitization,
`Jets::Html::TargetScrubber` targets them for removal.


```ruby
scrubber = Jets::Html::TargetScrubber.new
scrubber.tags = ['img']

html_fragment = Loofah.fragment('<a><img/ ></a>')
html_fragment.scrub!(scrubber)
html_fragment.to_s # => "<a></a>"
```

#### Custom Scrubbers

You can also create custom scrubbers in your application if you want to.

```ruby
class CommentScrubber < Jets::Html::PermitScrubber
  def initialize
    super
    self.tags = %w( form script comment blockquote )
    self.attributes = %w( style )
  end

  def skip_node?(node)
    node.text?
  end
end
```

See `Jets::Html::PermitScrubber` documentation to learn more about which methods can be overridden.

#### Custom Scrubber in a Jets app

Using the `CommentScrubber` from above, you can use this in a Jets view like so:

```ruby
<%= sanitize @comment, scrubber: CommentScrubber.new %>
```

## Read more

Loofah is what underlies the sanitizers and scrubbers of jets-html-sanitizer.
- [Loofah and Loofah Scrubbers](https://github.com/flavorjones/loofah)

The `node` argument passed to some methods in a custom scrubber is an instance of `Nokogiri::XML::Node`.
- [`Nokogiri::XML::Node`](http://nokogiri.org/Nokogiri/XML/Node.html)
- [Nokogiri](http://nokogiri.org)

## Contributing to Jets Html Sanitizers

Jets Html Sanitizers is work of many contributors. You're encouraged to submit pull requests, propose features and discuss issues.

See [CONTRIBUTING](CONTRIBUTING.md).

## License
Jets Html Sanitizers is released under the [MIT License](MIT-LICENSE).
