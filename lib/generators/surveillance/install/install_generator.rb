module Surveillance
  class InstallGenerator < Rails::Generators::Base
    # Copied files come from templates folder
    source_root File.expand_path('../templates', __FILE__)

    # Generator desc
    desc "Surveillance installation generator"

    def welcome
      say "Installing surveillance files ..."
    end

    def copy_initializer_file
      say "Copying Surveillance initializer template"
      copy_file "initializer.rb", "config/initializers/surveillance.rb"
    end

    def copy_migrations
      say "Installing migrations, don't forget to `rake db:migrate`"
      rake "surveillance:install:migrations"
    end

    def mount_engine
      mount_path = ask(
        "Where would you like to mount the Surveillance engine ? [/surveillance]"
      ).presence || '/surveillance'

      gsub_file "config/routes.rb", /mount Surveillance::Engine.*\'/, ''

      path = mount_path.match(/^\//) ? mount_path : "/#{ mount_path }"
      route "mount Surveillance::Engine => '#{ path }'"
    end
  end
end
