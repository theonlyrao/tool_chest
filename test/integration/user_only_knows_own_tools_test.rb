require 'test_helper'

class UserOnlyKnowsOwnToolsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user only knows own tools" do
    one = User.create(username: "one", password: "pass")
    two = User.create(username: "two", password: "word")

    one_tool_a = Tool.create(name: "one a", price: "2", quantity: "3", user_id: one.id)
    one_tool_b = Tool.create(name: "one b", price: "2", quantity: "3", user_id: one.id)
    two_tool = Tool.create(name: "two", price: "2", quantity: "3", user_id: two.id)

    visit login_path
    fill_in "Username", with: one.username
    fill_in "Password", with: one.password
    click_on "Log In To Your Account"

    assert page.has_content?("one a"), "Does not have one a"
    assert page.has_content?("one b"), "Does not have one b"
    # assert page.has_content?("Newest tool: one b"), "Does not have newest tool as one b"
    refute page.has_content?("two"), "shows two for user one"

    click_on "Logout"
    fill_in "Username", with: two.username
    fill_in "Password", with: two.password
    click_on "Log In To Your Account"

    refute page.has_content?("one a"), "Does have one a for user two"
    refute page.has_content?("one b"), "Does have one b for user two"
    assert page.has_content?("two"), "does not show two for user one"
  end
end
