json.line_items @cart.line_items do |line_item|
    if (line_item == @line_item )
            json.current_item true
            if(line_item.quantity >1)
            json.quantity           line_item.quantity-1
            else
                line_item.destroy
    end
end

