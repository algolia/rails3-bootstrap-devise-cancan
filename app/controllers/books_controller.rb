class BooksController < ApplicationController

  def index
  end

  def search
    if params[:q].blank?
      render text: ''
      return
    end

    secured_index = Book.index(Book::SECURED_INDEX_NAME)
    tags = if current_user
      if current_user.has_role? :admin
        [['public', 'private']] # public OR private
      elsif current_user.has_role? :VIP
        ['public', ['premium', 'standard']] # public AND (premium OR standard)
      else
        ['public', 'standard'] # public AND standard
      end
    else
      ['public', 'standard'] # public AND standard
    end
    @results = secured_index.search(params[:q], tagFilters: tags)
    render text: @results['hits'].map { |hit| "<li>#{hit['_highlightResult']['name']['value']}</li>" }.join
  end

end
