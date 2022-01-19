@sample_tc6
Feature: Sample TC6

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"
    Then I type "woody" into element with xpath "//input[@name='username']"
    Then I type "test@example.com" into element with xpath "//input[@name='email']"
    Then I type "Asdfgh1!" into element with xpath "//input[@name='password']"
    Then I type "Asdfgh1!" into element with xpath "//input[@id='confirmPassword']"
    Then I type "Woody" into element with xpath "//input[@name='name']"

  Scenario: Good
    When element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']" should not be selected
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='agreedToPrivacyPolicy-error']" should not be visible
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"

  Scenario: Bad
    When element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']" should not be selected
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='agreedToPrivacyPolicy-error']" should contain text "Must check!"
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
