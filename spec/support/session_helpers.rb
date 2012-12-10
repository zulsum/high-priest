module Support
  module SessionHelpers
    def form_sign_in(username, password)
      visit root_path
      click_on "Sign in"

      within "form" do
        fill_in "Username", with: username
        fill_in "Password", with: password
        click_on "Sign in"
      end
    end
  end
end
