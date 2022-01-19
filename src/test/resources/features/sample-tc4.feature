@sample_tc4
Feature: Sample TC4

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"
    Then I type "woody" into element with xpath "//input[@name='username']"
    Then I type "test@example.com" into element with xpath "//input[@name='email']"
    Then I type "Woody" into element with xpath "//input[@name='name']"
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"

  Scenario Outline: Good password
    Then I type <password> into element with xpath "//input[@name='password']"
    Then element with xpath "//input[@id='confirmPassword']" should be enabled
    Then I type <password> into element with xpath "//input[@id='confirmPassword']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='password-error']" should not be visible
    Then element with xpath "//label[@id='confirmPassword-error']" should not be visible
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"
    Examples:
      | password     |
      | "Asdfgh1!"   |
      | "aaaaa"      |
      | "!@#$%^&*()" |
      | "aaaa "      |
      | " aaaa"      |
      | "     "      |

  Scenario Outline: No match password
    Then I type <password> into element with xpath "//input[@name='password']"
    Then element with xpath "//input[@id='confirmPassword']" should be enabled
    Then I type <password2> into element with xpath "//input[@id='confirmPassword']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='password-error']" should not be visible
    Then element with xpath "//label[@id='confirmPassword-error']" should have text as "Passwords do not match!"
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
    Examples:
      | password    | password2   |
      | "Asdfgh1!"  | "Asdfgh2!"  |
      | "Asdfgh1!"  | "Asdfgh1! " |
      | "Asdfgh1!"  | " Asdfgh1!" |
      | "Asdfgh1! " | "Asdfgh1!"  |
      | " Asdfgh1!" | "Asdfgh1!"  |

  Scenario: Empty password
    Then element with xpath "//input[@id='confirmPassword']" should be disabled
    Then I type "Asdfgh1!" into element with xpath "//input[@id='password']"
    Then I type "Asdfgh1!" into element with xpath "//input[@id='confirmPassword']"
    Then I clear element with xpath "//input[@name='password']"
    Then element with xpath "//input[@id='confirmPassword']" should be disabled
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='password-error']" should be displayed
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"

  Scenario Outline: Bad password
    Then I type <password> into element with xpath "//input[@name='password']"
    Then element with xpath "//input[@id='confirmPassword']" should be enabled
    Then I type <password> into element with xpath "//input[@id='confirmPassword']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='password-error']" should be displayed
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
    Examples:
      | password |
      | " "      |
      | "aaaa"   |
