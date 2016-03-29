class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true,:format => /\D.*@gmail.com/
  validates :password, :presence => true, :length => {:minimum => 5, :maximum => 10}
  scope :first_record,  -> { self.all}
  has_one :image, as: :entity
  accepts_nested_attributes_for :image
  # validates :email_id
#   
  # def email_id
    # code
  # end
  before_validation do | user |
    if password.blank?
      self.password = "password"
      self.confirm_password = "password"
    end
  end
  
  before_save :change_name
  before_validation :verify_confirm_password
  before_save :encrypt_password
  
  def encrypt_password
   self.password = Digest::MD5.hexdigest(password)
   self.confirm_password =  Digest::MD5.hexdigest(confirm_password)
  end
  
  before_destroy :save_records
   def save_records
     File.open("#{Rails.root}/log/save_records.json", "a+") { |foo| foo.write(self.to_json)}
   end
  
  
  def verify_confirm_password
    if password != confirm_password
      errors.add(:base,  "Password and confirm password are not equal")
    end 
  end 
  def change_name
    self.name = "Hello ruby!"  
  end
  def self.authenticate(user_records)
    @user = User.where(:email => user_records[:email], :password =>Digest::MD5.hexdigest(user_records[:password])).last
    if @user 
      @user
    else
      nil
    end
  end
end
