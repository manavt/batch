class Import
  def self.import
    file = File.open("#{Rails.root}/log/product", "r").collect {|line| line} # opening file to read
    file.each do | fl | # file 
      byebug
    l = fl.split
     @user = Product.create(brand: l[0], price: l[1], product_type: l[2] )
     if @user and l[3]
       f = File.new(l[3])
       Image.create(:photo => (f), entity: @user)
     end
    end
  end
end