json.line_items @cart.line_items do |line_item|
    json.destroy                 line_item.destroy
    end
end