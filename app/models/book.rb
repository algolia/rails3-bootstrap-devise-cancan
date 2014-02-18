class Book < ActiveRecord::Base
  include AlgoliaSearch

  attr_protected

  PUBLIC_INDEX_NAME  = "Book_#{Rails.env}"
  SECURED_INDEX_NAME = "SecuredBook_#{Rails.env}"

  # use tags to handle security
  algoliasearch index_name: SECURED_INDEX_NAME do
    attributesToIndex [:name]
    tags do
      [released ? 'public' : 'private', premium ? 'premium' : 'standard']
    end

    add_index PUBLIC_INDEX_NAME, if: :public? do
      attributesToIndex [:name]
    end
  end

  private
  def public?
    released && !premium
  end

end
