class User < ActiveRecord::Base
  attr_accessor :password
  
  validates :name, :presence => true,
                   :uniqueness => true
                 
  validates :password, :presence => true,    
            :confirmation =>true;
          
  before_save :encrypt_password

  def self.authenticate(name,pword)
    user = find_by_name(name)
    return nil if user.nil?
    return user if user.has_password?(pword)
  
  end
  
  def has_password?(pword) 
    encrypted_password == encrypt(pword)
  end
  
  
  private
    def encrypt_password 
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}warblely#{password}")
    end
    
    def encrypt(pword)
      secure_hash("#{salt}-_#{pword}")
    end
  
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
