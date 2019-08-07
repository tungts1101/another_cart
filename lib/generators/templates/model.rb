belongs_to <%= ":#{@user_cname.downcase}" %>
belongs_to <%= ":#{@product_cname.downcase}" %>

validates <%= user_id %>, presence: true
validates <%= product_id %>, presence: true
