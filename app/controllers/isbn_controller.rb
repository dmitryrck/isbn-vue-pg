class IsbnController < ApplicationController
  def create
    @isbn = RubyIsbn.find_or_create_by(isbn: params[:isbn])

    json_response = { isbn: @isbn.isbn, status: 200 }

    if @isbn.save
      json_response[:digit] = @isbn.digit
      json_response[:id] = @isbn.id
    else
      json_response[:error] = "Unprocessable Entity"
      json_response[:status] = 422
    end

    render json: json_response, status: json_response[:status]
  end
end
