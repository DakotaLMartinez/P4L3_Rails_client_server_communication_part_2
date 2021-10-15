class UserBooksController < ApplicationController
  def create
    user_book = current_user.user_books.build(user_book_params)
    if user_book.save
      render json: user_book, status: :created
    else
      render json: user_book.errors, status: :unprocessable_entity
    end
  end

  def update
    user_book = UserBook.find(params[:id])
    if user_book.update(update_user_book_params)
      render json: user_book, status: :ok
    else
      render json: user_book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user_book = UserBook.find(params[:id])
    user_book.destroy
  end

  private

  def user_book_params
    params.permit(:book_id)
  end

  def update_user_book_params
    params.permit(:read)
  end
end
