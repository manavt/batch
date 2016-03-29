class Product < ActiveRecord::Base
  has_many :images, as: :entity
end
 # => 
# p = Product.last
# p.images => select * from images where entity_id = p.id and entity_type = 'Product'
# 
# 
# u = User.last
# u.image => select * from images where entity_id = u.id and entity_type = 'User'
