class Pointers < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :gmaps, :description, :full_desc
  acts_as_gmappable :process_geocoding => false

  validates :latitude, :presence => true,  :uniqueness => {:scope => :longitude}


  def gmaps4rails_address
    #self.address #describe how to retrieve the address from your model
        "#{self.latitude}, #{self.longitude}"
  end

  def gmaps4rails_infowindow

    "<p style ='font-size: 12px; font-family = 'verdana'; '> #{self.description} <p><br><a data-remote='true' href='/home/full_desc?bla=#{self.id}'>Full description</a>"

    end
end
