require 'test_helper'

class AdminCannotUpdateAnotherUserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "admin can't update another user" do
    admin = User.create(username: "admin", password: "tough", role: 1)
    user = User.create(username: "Joe", password: "regular", role: 0)

    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_on "Log In To Your Account"
    visit edit_user_path(user.id)

    assert edit_user_path(user.id)
    refute page.has_content? "Joe"
    assert page.has_content? "The page you were looking for doesn't exist (404)"
  end
end
