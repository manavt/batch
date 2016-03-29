
class Export
  
  def self.in_xml
    FileUtils.mkdir_p "#{Rails.root}/log/XML"
    User.all.map do | i |
     File.open("#{Rails.root}/log/XML/#{i.email}.xml", "w") {| foo | foo.write(i.to_xml)}    
    end
  end
  
  def self.in_csv
    filepath = "#{Rails.root}/log/user.csv"
    CSV.open(filepath, "a+") do |csv|
           csv << User.column_names # header
           User.all.each do | user |
             csv << ActiveRecord::Base.connection.select_one("select * from users where id = #{user.id}").values
           end
    end
  end
  
  
  def self.in_json
    FileUtils.mkdir_p "#{Rails.root}/log/JSON"
    User.all.map do | i |
     File.open("#{Rails.root}/log/JSON/#{i.id}.json", "w") {| foo | foo.write(i.to_json)}    
    end
  end
end


