@sample_tc8
Feature: Sample TC8

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"

  Scenario Outline:
    Then I type <username> into element with xpath "//input[@name='username']"
    Then I type <email> into element with xpath "//input[@name='email']"
    Then I type <password> into element with xpath "//input[@name='password']"
    Then I type <password> into element with xpath "//input[@id='confirmPassword']"
    When I click on element with xpath "//input[@name='name']"
    Then I type <fn> into element with xpath "//*[@role='dialog']//input[@name='firstName']"
    Then I type <ln> into element with xpath "//*[@role='dialog']//input[@name='lastName']"
    Then I type <mn> into element with xpath "//*[@role='dialog']//input[@name='middleName']"
    Then I click on element with xpath "//*[@role='dialog']//*[@role='button' and .='Save']"
    Then I click on element with xpath <genderPath>
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"
    Then I click on element with xpath "//*[@type='submit']"
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"
    And element with xpath "//body" should not contain text <password>
    And element with xpath "//*[@name='firstName']" should have text as <fn>
    And element with xpath "//*[@name='lastName']" should have text as <ln>
    And element with xpath "//*[@name='middleName']" should have text as <mn>
    And element with xpath "//*[@name='name']" should have text as <name>
    And element with xpath "//*[@name='agreedToPrivacyPolicy']" should have text as "true"
    And element with xpath "//*[@name='username']" should have text as <username>
    And element with xpath "//*[@name='email']" should have text as <email>
    And element with xpath "//*[@name='gender']" should have text as <gender>
    Examples:
      | username | email              | password   | name                 | fn      | ln           | mn  | genderPath                                    | gender   |
      | "woody"  | "test@example.com" | "Asdfgh1!" | "Woody M Woodpecker" | "Woody" | "Woodpecker" | "M" | "//input[@name='gender' and @value='male']"   | "male"   |
      | "woody"  | "test@example.com" | "Asdfgh1!" | "Woody M Woodpecker" | "Woody" | "Woodpecker" | "M" | "//input[@name='gender' and @value='female']" | "female" |
