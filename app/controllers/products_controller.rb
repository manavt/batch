class ProductsController < ApplicationController
  def index
    @product = Product.all
  end

  def new
    @product = Product.new
  end
  def trans
    @product=Product.find(params[:id])
  end  
  def trans_pay
    
  current_user = User.find session[:user_id]
  @product=Product.find(params[:id])
  @result = Braintree::Transaction.sale(
  :amount => 5000,
  :credit_card => {:number => params[:user][:credit_card_number],
    :expiration_date => "#{params[:user]['date(2i)']}/#{params[:user]['date(1i)']}"},
    :options=> {store_in_vault: true }
    )
if @result.success?
current_user.update(braintree_customer_id: @result.transaction.customer_details.id)
redirect_to :action=>"index", notice: "Congraulations! Your transaction has been successfully!"
else
redirect_to :action=>"trans", notice: "Transaction fail"
end
end
  def create
    image_attributes = product_params[:image][:photo]
    product_params.delete(:image)
    @product = Product.new(product_params)
       if @product.save
         image_attributes.each do | image |
           Image.create!(:photo => image, :entity => @product )
         end
         redirect_to :action=>"index"
        flash[:notice] = "Successfully created user records :)"
        else
          render :new
     end
  end
  

  def edit
  end

  def show
  end
  private
  def product_params
    params.require(:product).permit!
  end
end

# belongs_to
# has_one
# has_many
# 
# has_one :through
# has_many :through
# has_and_belongs_to_many
# polymorphism
# STI



   # Image
    # /\/\
 # product user subscriber article
#  
#  
#  
 # polymorphism
#  
 # 1. first make the table as polymorphic true
 # 2. add the below two colum to the table
    # entity_id
    # entity_type
#     
 # 3. wherever you are wiling to use image tell that table to search based on entity not based on its own id.   
