describe "signing in and out" do
  include Support::SessionHelpers

  fixtures :users

  it "provides the option to sign in" do
    form_sign_in(registered_user.username, "secret123")

    page.should have_content("Signed in successfully.")
    page.should have_content("Signed in as " + registered_user.username)
    current_path.should == root_path
  end

  it "provides the option to sign out" do
    form_sign_in(registered_user.username, "secret123")

    click_on "Sign out"
    page.should have_link("Sign in")
    current_path.should == root_path
  end

  it "returns an error upon wrong username or password" do
    form_sign_in(registered_user.username, "wrong_pass")
    verify_incorrect_sign_in

    form_sign_in("nobody", "secret123")
    verify_incorrect_sign_in
  end

  private

  def registered_user
    users(:liam)
  end

  def verify_incorrect_sign_in
    page.should have_content("Invalid username or password.")
    current_path.should == new_user_session_path
  end
end
