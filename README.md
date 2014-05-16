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
