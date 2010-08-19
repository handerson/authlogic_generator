class AuthlogicGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      #Controllers
      m.template "controllers/application_controller.rb", "app/controllers/application_controller.rb"
      m.template "controllers/users_controller.rb", "app/controllers/#{file_name.pluralize}_controller.rb"
      m.template "controllers/user_sessions_controller.rb", "app/controllers/#{file_name}_sessions_controller.rb"
      m.template "controllers/password_resets_controller.rb", "app/controllers/password_resets_controller.rb"

      #Models
      m.template "models/user.rb", "app/models/#{file_name}.rb"
      m.template "models/user_session.rb", "app/models/#{file_name}_session.rb"
      m.template "models/mailer.rb", "app/models/mailer.rb"

      #User Views
      m.directory "app/views/#{file_name.pluralize}"
      m.template "views/users/edit.html.erb", "app/views/#{file_name.pluralize}/edit.html.erb"
      m.file "views/users/_form.erb", "app/views/#{file_name.pluralize}/_form.html.erb"
      m.template "views/users/index.html.erb", "app/views/#{file_name.pluralize}/index.html.erb"
      m.template "views/users/new.html.erb", "app/views/#{file_name.pluralize}/new.html.erb"
      m.template "views/users/show.html.erb", "app/views/#{file_name.pluralize}/show.html.erb"

      #Session Views
      m.directory "app/views/#{file_name}_sessions"
      m.template "views/user_sessions/new.html.erb", "app/views/#{file_name}_sessions/new.html.erb"

      # Reset Password Views
      m.directory "app/views/password_resets"
      m.template "views/password_resets/edit.html.erb", "app/views/password_resets/edit.html.erb"
      m.file "views/password_resets/new.html.erb", "app/views/password_resets/new.html.erb"

      #Mailer Views
      m.directory "app/views/mailer"
      m.file "views/mailer/confirmation.erb", "app/views/mailer/confirmation.erb"
      m.file "views/mailer/password_reset_instructions.erb", "app/views/mailer/password_reset_instructions.erb"
      
      #Routes
      m.route "resources :#{file_name.pluralize}, :member => {:confirm => :get}"
      m.route "resources :#{file_name}_sessions"
      m.route "resources :password_resets"
      m.route "login 'login', :controller => '#{file_name}_sessions', :action => 'new'"
      m.route "logout 'logout', :controller => '#{file_name}_sessions', :action => 'destroy'"
      m.route "connect 'confirm/:id', :controller => '#{file_name.pluralize}', :action => 'confirm'"
      m.route "reset_password 'password/:anything', :controller => 'password_resets', :action => 'new'"

      #Migration
      m.migration_template "migrate/create_users.rb", "db/migrate/", :migration_file_name => 'create_users'
    end
  end
end

module Rails
  module Generator
    module Commands

      class Base
        def route_code(route_options)
          "map.#{route_options}"
        end
      end


      class Create
        def route(route_options)
          sentinel = 'ActionController::Routing::Routes.draw do |map|'
          logger.route route_code(route_options)
          gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |m|
            "#{m}\n  #{route_code(route_options)}\n"
          end
        end
      end

      class Destroy
        def route(route_options)
          logger.remove_route route_code(route_options)
          to_remove = "\n  #{route_code(route_options)}"
          gsub_file 'config/routes.rb', /(#{to_remove})/mi, ''
        end
      end

    end
  end
end

