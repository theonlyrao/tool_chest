require 'test_helper'

class SessionKnowsUserIdAfterLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "session knows user after successful login" do
    legit = User.create(username: "legit", password: "easy")

    visit login_path
    fill_in "Username", with: "legit"
    fill_in "Password", with: "easy"
    click_on "Log In To Your Account"

    assert_equal legit.id, legit.sessions.last.user_id
  end

  test "session is gone after user logs out" do
    legit = User.create(username: "legit", password: "easy")

    visit login_path
    fill_in "Username", with: "legit"
    fill_in "Password", with: "easy"
    click_on "Log In To Your Account"
    click_on "Logout"

    assert Session.find_by(user_id: legit.id).nil?
  end
end
