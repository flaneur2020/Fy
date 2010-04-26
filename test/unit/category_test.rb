require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "test Category.as_list" do
    list = Category.as_list
    assert_equal list.size, Category.count(:all)
  end
end
