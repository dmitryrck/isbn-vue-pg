class Home < ApplicationController
  def index
    render file: Rails.root.join("public", "index"), layout: false
  end
end
