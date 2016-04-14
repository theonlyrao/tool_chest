require 'test_helper'

class UserCanUpdateHerselfButNotOthersTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user can update herself" do
    worker = User.create(username: "blacksmith", password: "asdf")
    new_name = "potter"

    visit login_path
    fill_in "Username", with: worker.username
    fill_in "Password", with: worker.password
    click_on "Log In To Your Account"

    visit edit_user_path(worker.id)
    fill_in "Username", with: new_name
    click_on "Update My Account"

    assert page.has_content? "You have updated yourself."
    assert page.has_content? "#{new_name}"
    refute User.find_by(username: "blacksmith")
  end

  test "user cannot update another user" do
    yes = User.create(username: "yes", password: "pass")
    no = User.create(username: "no not mine thanks", password: "word")

    visit login_path
    fill_in "Username", with: yes.username
    fill_in "Password", with: yes.password
    click_on "Log In To Your Account"

    visit edit_user_path(no.id)

    assert edit_user_path(no.id)
    refute page.has_content? "no not mine thanks"
    assert page.has_content? "The page you were looking for doesn't exist (404)"
  end
end
