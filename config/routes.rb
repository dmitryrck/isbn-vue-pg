Rails.application.routes.draw do
  root to: "home#index"
  post "/isbn", to: "isbn#create", as: :create_isbn
end
