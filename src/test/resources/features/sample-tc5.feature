@sample_tc5
Feature: Sample TC5

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"
    Then I type "woody" into element with xpath "//input[@name='username']"
    Then I type "test@example.com" into element with xpath "//input[@name='email']"
    Then I type "Asdfgh1!" into element with xpath "//input[@name='password']"
    Then I type "Asdfgh1!" into element with xpath "//input[@id='confirmPassword']"
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"

  Scenario Outline: Good name
    When I click on element with xpath "//input[@name='name']"
    Then I type <fn> into element with xpath "//*[@role='dialog']//input[@name='firstName']"
    Then I type <ln> into element with xpath "//*[@role='dialog']//input[@name='lastName']"
    Then I type <mn> into element with xpath "//*[@role='dialog']//input[@name='middleName']"
    Then I click on element with xpath "//*[@role='dialog']//*[@role='button' and .='Save']"
    Then element with xpath "//input[@name='name']" should have attribute "value" as <name>
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='name-error']" should not be visible
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"
    Examples:
      | fn  | ln  | mn  | name    |
      | "F" | "L" | "M" | "F M L" |
      | "F" | "L" | ""  | "F L"   |
      | "F" | ""  | "M" | "F M"   |
      | ""  | "L" | "M" | "M L"   |
      | "F" | ""  | ""  | "F"     |
      | ""  | "L" | ""  | "L"     |
      | ""  | ""  | "M" | "M"     |

  Scenario Outline: Good name parse
    When I type <name> into element with xpath "//input[@name='name']"
    Then I click on element with xpath "//input[@name='name']"
    Then element with xpath "//*[@role='dialog']//input[@name='firstName']" should have attribute "value" as <fn>
    Then element with xpath "//*[@role='dialog']//input[@name='lastName']" should have attribute "value" as <ln>
    Then element with xpath "//*[@role='dialog']//input[@name='middleName']" should have attribute "value" as <mn>
    Examples:
      | fn  | ln  | mn  | name    |
      | "F" | "L" | "M" | "F M L" |
      | "F" | "L" | ""  | "F L"   |

  Scenario: Empty name
    When I click on element with xpath "//input[@name='name']"
    Then I clear element with xpath "//*[@role='dialog']//input[@name='firstName']"
    Then I clear element with xpath "//*[@role='dialog']//input[@name='lastName']"
    Then I clear element with xpath "//*[@role='dialog']//input[@name='middleName']"
    Then I click on element with xpath "//*[@role='dialog']//*[@role='button' and .='Save']"
    Then element with xpath "//input[@name='name']" should have attribute "value" as ""
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='name-error']" should have text as "This field is required."
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
