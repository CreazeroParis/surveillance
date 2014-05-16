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

      resources :exports, only: [:show]
      resources :attempts
    end
  end

  resources :surveys, only: [:index, :show], shallow: true do
    namespace :response do
      resources :attempts, only: [:new, :edit, :update] do
        member do
          get "/complete", action: "complete", as: "complete"
        end
      end
      resources :partial_attempts, only: [:update]
    end
  end
end
