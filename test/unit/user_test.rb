require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "login" do
    user=User.login(
      :name => 'ssword',
      :pass => 'aaaaaa'
    )
    assert_not_nil(user)

    user=User.login(
      :name => 'ssword',
      :pass => '123456'
    )
    assert_nil(user)
  end
end
