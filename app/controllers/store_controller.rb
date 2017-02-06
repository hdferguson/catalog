class StoreController < ApplicationController
  def visits
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] +=1
  end
  def index
    @products = Product.order(popularity: :DESC)
    @counter = visits
    session[:counter] = @counter
    @message = "You really should buy something. You've been here #{@counter} times without buying anything." if session[:counter] > 4
    respond_to do |format|
        format.html {
          if (params[:spa] && params[:spa] == "true")
              render 'index_spa'
              # the else case below is by default
              # else
              #    render 'index'
          end
        }
        format.json {render json: Product.order(sort_by + ' ' + order)}
    end
  end
  
  private 
    def sort_by
       %w(title
          price
          popularity).include?(params[:sortby]) ? params[:sort_by] : 'popularity'
    end
    def order
       %w(asc desc).include?(params[:order]) ? params[:order] : 'asc'
    end
end
