@sample_tc2
Feature: Sample TC2

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"
    Then I type "test@example.com" into element with xpath "//input[@name='email']"
    Then I type "Asdfgh1!" into element with xpath "//input[@name='password']"
    Then I type "Asdfgh1!" into element with xpath "//input[@id='confirmPassword']"
    Then I type "Woody" into element with xpath "//input[@name='name']"
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"

  Scenario Outline: Good username
    Then I type <username> into element with xpath "//input[@name='username']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='username-error']" should not be visible
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"
    Examples:
      | username  |
      | "aa"      |
      | "Zxcvbnm" |

  Scenario Outline: Short username
    Then I type <username> into element with xpath "//input[@name='username']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='username-error']" should have text as "Please enter at least 2 characters."
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
    Examples:
      | username |
      | "A"      |
      | "Й"      |
      | "И̌"     |

  Scenario: No username
    Then I clear element with xpath "//input[@name='username']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='username-error']" should have text as "This field is required."
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"

  Scenario Outline: Bad username
    Then I type <username> into element with xpath "//input[@name='username']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='username-error']" should be displayed
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
    Examples:
      | username |
      | "  "     |
      | "     "  |
