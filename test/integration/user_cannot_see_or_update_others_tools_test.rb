require 'test_helper'

class UserCannotSeeOrUpdateOthersToolsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user cannot see tools of others" do
    one = User.create(username: "one", password: "pass")
    two = User.create(username: "two", password: "word")

    one_tool_a = Tool.create(name: "one a", price: "2", quantity: "3", user_id: one.id)
    one_tool_b = Tool.create(name: "one b", price: "2", quantity: "3", user_id: one.id)
    two_tool = Tool.create(name: "two", price: "2", quantity: "3", user_id: two.id)

    visit login_path
    fill_in "Username", with: one.username
    fill_in "Password", with: one.password
    click_on "Log In To Your Account"

    visit user_tool_path(two.id, two_tool.id)
    assert page.has_content? "The page you were looking for doesn't exist (404)"
  end

  test "user cannot edit tools of others" do
    one = User.create(username: "one", password: "pass")
    two = User.create(username: "two", password: "word")

    one_tool_a = Tool.create(name: "one a", price: "2", quantity: "3", user_id: one.id)
    one_tool_b = Tool.create(name: "one b", price: "2", quantity: "3", user_id: one.id)
    two_tool = Tool.create(name: "two", price: "2", quantity: "3", user_id: two.id)

    visit login_path
    fill_in "Username", with: one.username
    fill_in "Password", with: one.password
    click_on "Log In To Your Account"

    visit edit_user_tool_path(two.id, two_tool.id)
    assert page.has_content? "The page you were looking for doesn't exist (404)"

  end
end
