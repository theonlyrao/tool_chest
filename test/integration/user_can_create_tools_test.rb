require 'test_helper'

class UserCanCreateToolsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user can create tools" do
    blacksmith = User.create(username: "blacksmith", password: "asdf")
    visit login_path
    fill_in "Username", with: blacksmith.username
    fill_in "Password", with: blacksmith.password
    click_on "Log In To Your Account"

    click_on "Create A New Tool"

    assert_equal new_tool_path, current_path

    fill_in "tool_name", with: "anvil"
    fill_in "tool_price", with: "99"
    fill_in "tool_quantity", with: "1"
    click_on "Create Tool"

    assert_equal "anvil", Tool.last.name
    assert_equal blacksmith.id, Tool.last.id
    assert page.has_content? "anvil"
  end

  test "user can see multiple tools" do
    skip
    blacksmith = User.create(username: "blacksmith", password: "asdf")
    tongs = Tool.create(name: "tongs", price: "2", quantity: "3", user_id: blacksmith.id)
    water = Tool.create(name: "water", price: "2", quantity: "3", user_id: blacksmith.id)

    visit user_path(blacksmith.id)
    assert page.has_content?("anvil")
    assert page.has_content?("water")

    click_on "water"
    assert tool_path(water.id), current_path
  end
end
