require 'test_helper'

class AdminCanCreateToolsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "admin can create tool" do
    admin = User.create(username: "admin", password: "tough", role: 1)
    user = User.create(username: "Joe", password: "regular", role: 0)

    visit login_path
    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_on "Log In To Your Account"

    click_on "Create A New Tool"
    assert_equal admin_tools_new_path, current_path

    fill_in "tool_name", with: "anvil"
    fill_in "tool_price", with: "99"
    fill_in "tool_quantity", with: "1"
    select "Joe", from: "tool_user"
    click_on "Create Tool"

    assert_equal "anvil", Tool.last.name
    assert_equal user.id, Tool.last.user_id
  end

  test "admin must assign tool to user" do

  end

end
