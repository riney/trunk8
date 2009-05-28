# == Schema Information
#
# Table name: keys
#
#  id          :integer         not null, primary key
#  license_key :string(255)
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Key < ActiveRecord::Base
  URL_SIZE = 8
  
  # in days
  KEY_EXPIRATION = 7
  
  VALID_CHARACTERS = 'ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz2346789-@~'.split(//)
  
  before_create :set_url
  validates_presence_of :license_key, :message => "You gotta put in a key!"
  validates_length_of :license_key, :maximum => 255, :message => "Key's too freakin' long, man!"
  
  def set_url
    begin potential_url = Key.generate_url end while Key.exists?(:url => potential_url)
    self.url = potential_url
  end
  
  # generate a random url for a key, of the length specified by URLSIZE
  def self.generate_url
    url = ''
    URL_SIZE.times { url << VALID_CHARACTERS[rand(VALID_CHARACTERS.size)] }
    url
  end
  
  # called periodically by the pearl daemon to remove keys that are older than 7 days old
  def self.prune
    Key.delete_all([ "created_at < ?", KEY_EXPIRATION.days.ago ])
  end
end
