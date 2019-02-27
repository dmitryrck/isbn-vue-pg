require "rails_helper"

describe "Home" do
  it "should get the digit", js: true do
    visit "/"

    fill_in "ISBN", with: "978014300723"

    click_on "Get digit"

    expect(page).to have_content "Complete ISBN: 9780143007234"
  end

  it "should hide 'Complete ISBN' message if user changes the isbn", js: true do
    visit "/"

    fill_in "ISBN", with: "978014300723"

    click_on "Get digit"

    expect(page).to have_content "Complete ISBN: 9780143007234"

    fill_in "ISBN", with: "123"

    expect(page).not_to have_content "Complete ISBN"
  end

  it "should show errors", js: true do
    visit "/"

    fill_in "ISBN", with: "978014300723abc"

    click_on "Get digit"

    expect(page).to have_content "Error: Request failed with status code 422"
  end
end
