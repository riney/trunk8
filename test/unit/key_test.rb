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

require 'test_helper'

class KeyTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
