class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
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
              @spa = true
              @try=true
              render 'index_spa'
            else 
              @try = false
              # the else case below is by default
              # else
              #    render 'index'
          end
        }
        format.json {render json: Product.order(sort_by + ' ' + order)}
    end
  end
  
  def search
      products = Product.where("title LIKE '%#{params[:query]}%'")
      render json: products
  end
  
  private 
    def sort_by
       %w(title
          price
          popularity).include?(params[:sort_by]) ? params[:sort_by] : 'popularity'
    end
    def order
       %w(asc desc).include?(params[:order]) ? params[:order] : 'asc'
    end
    
    
    
end
