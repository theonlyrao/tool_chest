require 'test_helper'

class UserOnlyKnowsOwnToolsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user only knows own tools" do
    skip
    one = User.create(username: "one", password: "pass")
    two = User.create(username: "two", password: "word")


  end
end
