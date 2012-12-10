describe "creating a new user" do
  fixtures :users

  it "provides the option to create a new user" do
    visit root_path
    click_on "Sign up"

    within "form" do
      fill_in "Username", with: "peter"
      fill_in "e-mail", with: "peter@gmail.com"
      fill_in "Password", with: "secret123"
      fill_in "Confirm password", with: "secret123"
      click_on "Sign up"
    end

    verify_successful_sign_up "peter"
  end

  it "displays an error when trying to use an already taken username and allows creation using another one" do
    visit root_path
    click_on "Sign up"

    within "form" do
      fill_in "Username", with: users(:liam).username
      fill_in "e-mail", with: "liamn@gmail.com"
      fill_in "Password", with: "secret123"
      fill_in "Confirm password", with: "secret123"
      click_on "Sign up"
    end

    page.should have_content("Username has already been taken")

    within "form" do
      fill_in "Username", with: "liam60"
      fill_in "e-mail", with: "liam60@gmail.com"
      fill_in "Password", with: "secret123"
      fill_in "Confirm password", with: "secret123"
      click_on "Sign up"
    end

    verify_successful_sign_up "liam60"
  end

  private

  def verify_successful_sign_up(username)
    page.should have_content("Welcome! You have signed up successfully.")
    page.should have_content("Signed in as " + username)
    current_path.should == root_path
  end
end

describe "editing a user" do
  include Support::SessionHelpers

  fixtures :users

  it "provides the option to edit a user profile" do
    user = users(:liam)

    form_sign_in(user.username, "secret123")
    visit root_path
    click_on user.username

    within "form" do
      fill_in "Password", with: "secretPass123"
      fill_in "Confirm password", with: "secretPass123"
      fill_in "Current password", with: "secret123"
      click_on "Update"
    end

    page.should have_content("You updated your account successfully.")
    current_path.should == root_path
  end
end
