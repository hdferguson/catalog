class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    
    def add_product(product)
      current_item = line_items.find_by(product_id: product.id)
      if current_item
        current_item.quantity += 1
      else
        current_item = line_items.build(product_id: product.id)
      end
      current_item
    end
    
    def total_price 
      line_items.to_a.sum { |item| item.total_price } 
    end
    
    def decrease(line_item_id)
      current_item = LineItem.find_by_id(line_item_id)
      product = Product.find_by_id(current_item.product_id)
      product.popularity -=1
      if current_item.quantity > 1
        current_item.quantity -= 1
      else
        current_item.destroy
      end
      current_item
    end
end
