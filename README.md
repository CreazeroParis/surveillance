# Surveillance

Survey Rails 4 engine

## Installation

Add to Gemfile and bundle :

```ruby
gem 'surveillance', github: 'vala/surveillance'
```

Execute install generator :

```bash
rails generate surveillance:install
```

## Usage

- Configure with generated initializer
- Access admin at : `/<mount_path>/admin/surveys`
- Access surveys at : `/<mount_path>/surveys`
- Require the javascript lib in your application.js : `//= require surveillance`

### Overriding models or controllers

If you need to override a class from the system, e.g. adding a validation or
method to a model, a `before_action` to a controller or something like that,
you can use the "decorators" approach the following way :

1. Create a file with the name of the desired class under
`lib/decorators/surveillance/`, e.g. `lib/decorators/surveillance/attempt.rb`
2. Use `.class_eval` to reopen the class and modify it. e.g.
```ruby
# lib/decorators/surveillance/attempt.rb
Surveillance::Attemp.class_eval do
  def foo
    puts 'bar'
  end
end
```
