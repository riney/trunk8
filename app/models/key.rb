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
  VALID_CHARACTERS = 'ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz2346789-@~'.split(//)
  
  before_create :set_url
  validates_presence_of :license_key, :message => "You gotta put in a key!"
  
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
end
