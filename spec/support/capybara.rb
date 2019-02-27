Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: [
        "no-sandbox",
        "headless",
        "disable-popup-blocking",
        "disable-gpu",
        "window-size=1920,1200",
      ],
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
  )
end

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome
