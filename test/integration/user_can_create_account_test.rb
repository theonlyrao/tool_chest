require 'test_helper'

class UserCanCreateAccountTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user can create account" do
    dummy = Tool.create(name: "dummy", price: "49", quantity: "392")
    assert_equal 0, User.all.count

    visit new_user_path
    assert page.has_content?("Login"), "Login is not on the new user path"

    fill_in "user_username", with: "ashwin"
    fill_in "user_password", with: "junglejuice"
    click_on "Create My Account"

    assert_equal 1, User.all.count
    assert page.has_content?("Logout"), "Logout is not on the user show page"
    refute page.has_content?("Login"), "Login is present although user is logged in"
    assert page.has_content?("You have created an account."), "success message does not appear"
  end
end
