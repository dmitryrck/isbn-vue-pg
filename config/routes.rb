Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/isbn", to: "isbn#create", as: :create_isbn
end
