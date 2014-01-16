Surveillance::Engine.routes.draw do
  namespace :admin do
    resources :surveys, shallow: true do
      resources :sections do
        resources :questions do
          member do
            match "edit-rules", action: "edit_rules", as: "edit_rules", via: [:put, :patch]
          end
          resources :options
          resources :questions
        end
      end

      resources :attempts
    end
  end

  resources :surveys, only: [:index, :show] do
    resources :attempts, only: [:new, :create] do
      member do
        get "/complete", action: "complete", as: "complete"
      end
    end
  end
end
