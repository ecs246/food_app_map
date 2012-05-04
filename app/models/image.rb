class Image < ActiveRecord::Base
  has_many :related_images, :dependent => :destroy
  has_many :vendors, :through => :related_images
  
  def thumbnail
    url =~ /^(.*?)\.(.*?)$/i
    $1 + "_thumbnail." + $2
  end
  
end
