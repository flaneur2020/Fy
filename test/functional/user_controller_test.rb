require 'test_helper'

class UserControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "login" do
    post(:login, :user => {
      :name => 'ssword',
      :pass => 'aaaaaa'
    })
    assert_redirected_to  :controller => :admin,
                          :action     => :index
    assert_not_nil(session[:user_id])

    post(:login, :user => {
      :name => 'ssword',
      :pass => '123456'
    })
    assert_redirected_to :action => :login
    assert_nil(session[:user_id])
  end

  test "logout" do 
    post(:login, :user => {
      :name => 'ssword',
      :pass => 'aaaaaa'
    })
    assert_not_nil(session[:user_id])
    get(:logout)
    assert_nil(session[:user_id])
  end
end
