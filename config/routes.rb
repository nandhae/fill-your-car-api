Rails.application.routes.draw do
    root to: 'home#index'
    devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup',
                 password: 'secret'
               },
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations',
                 passwords: 'passwords'
               }
    resources :people
end
