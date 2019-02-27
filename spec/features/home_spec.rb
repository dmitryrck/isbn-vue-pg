require "rails_helper"

describe "Home" do
  it "should get the digit", js: true do
    visit "/"

    fill_in "ISBN", with: "978014300723"

    click_on "Get digit"

    expect(page).to have_content "Complete ISBN: 9780143007234"
  end

  it "should show errors", js: true do
    visit "/"

    fill_in "ISBN", with: "978014300723abc"

    click_on "Get digit"

    expect(page).to have_content "Error: Request failed with status code 422"
  end
end
