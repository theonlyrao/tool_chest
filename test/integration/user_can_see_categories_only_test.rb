require 'test_helper'

class UserCanSeeCategoriesOnlyTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user can see categories of own tools" do
    blacksmith = User.create(username: "blacksmith", password: "asdf")
    wet = Category.create(name: "wet")
    hot = Category.create(name: "hot")
    tongs = Tool.create(name: "tongs", price: "2", quantity: "3", user_id: blacksmith.id, category_id: hot.id)
    water = Tool.create(name: "water", price: "2", quantity: "3", user_id: blacksmith.id, category_id: wet.id)

    visit login_path
    fill_in "Username", with: blacksmith.username
    fill_in "Password", with: blacksmith.password
    click_on "Log In To Your Account"

    visit user_categories_path(blacksmith.id)

    assert page.has_content?("wet")
    assert page.has_content?("hot")
    assert page.has_content?("tongs")
    assert page.has_content?("water")
  end
end
