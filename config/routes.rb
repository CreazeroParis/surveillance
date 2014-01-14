Surveillance::Engine.routes.draw do
  namespace :admin do
    resources :surveys, shallow: true do
      resources :sections do
        resources :questions do
          member do
            put "edit-rules", action: "edit_rules", as: "edit_rules"
          end
          resources :options
          resources :questions
        end
      end
    end
  end
end
