# Magazine

Static file article system for Rails

## Installation

Add this line to your application's Gemfile:

    gem 'magazine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install magazine

## Usage

Step 1: make config/magazine.yml  
It is array of category and articles hierarchy
```
# config/magazine.yml
-
  category_slug: drip
  category_name: Coffee drip ways
  articles:
    -
      slug: water
      title: Water drip
    -
      slug: nel
      title Nel drip
    -
      slug: paper
      title Paper drip
-
  category_slug: beans
  category_name: Coffee beans
  articles:
    -
      slug: blue-mountain
      title: Blue mountain's blend
    -
      slug: kona
      title Kona's blend
```

Step 2: make config/initializer/magazine.rb  
Add configuration like below if you want to use review feature
```
# config/initializer/magazine.rb
Magazine.authorize_method_name = :logged_in_user?

# app/controller/application_controller.rb
class ApplicationController < ActionController::Base
  private
  def logged_in_user?
    session['user_id'].present?
  end
end
```

Step 3: mount routes
```
# config/routes.rb
MyApp::Application.routes.draw do
  mount Magazine::Engine => '/coffee'
end
```

Step 4: create view
```
# app/views/magazine/articles/index.html.erb
<%= @magazine_rack.data.to_json # this is yml data %>
<%= @category.to_json # this is only "/mount_point/:category_slug" path %>
```

```
# app/views/magazine/articles/show.html.erb
<%= @magazine_rack.data.to_json %>
<%= @category.to_json %>
<%= @article.to_json %>
```

## Contributing

1. Fork it ( https://github.com/halenohi/magazine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
