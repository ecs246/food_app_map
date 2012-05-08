class Image < ActiveRecord::Base
  validates :name, :url, :thumbnail, :presence => true
  has_many :related_images, :dependent => :destroy
  has_many :vendors, :through => :related_images
  
  def deprecated_thumbnail
    if url =~ /flickr/
      url =~ /^(.*)_b\.(.*?)$/i
      $1 + "_t." + $2
    else 
      url =~ /^(.*?)\.(.*?)$/i
      $1 + "_thumbnail." + $2
    end
  end
  
end
