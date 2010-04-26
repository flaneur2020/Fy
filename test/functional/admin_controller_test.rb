require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "login ok" do
    post(:login, :user => {
      :name => 'ssword',
      :pass => 'aaaaaa'
    })
    assert_redirected_to  :controller => :admin,
                          :action     => :index
    assert_not_nil(session[:user_id])
  end

  test "login orz" do
    post(:login, :user => {
      :name => 'ssword',
      :pass => '123456'
    })
    assert_redirected_to :action => :login
    assert_nil(session[:user_id])
  end

  test "login go back" do
    # TODO: like go post/list before login,
    # remember the parameters to flash[:from]
    # when login, redirect to where it from
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
