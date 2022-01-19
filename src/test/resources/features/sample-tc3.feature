@sample_tc3
Feature: Sample TC3

  Background:
    Given I open url "https://skryabin.com/webdriver/html/sample.html"
    Then I type "woody" into element with xpath "//input[@name='username']"
    Then I type "Asdfgh1!" into element with xpath "//input[@name='password']"
    Then I type "Asdfgh1!" into element with xpath "//input[@id='confirmPassword']"
    Then I type "Woody" into element with xpath "//input[@name='name']"
    Then I click on element with xpath "//input[@type='checkbox' and @name='agreedToPrivacyPolicy']"

  Scenario Outline: Good email
    Then I type <email> into element with xpath "//input[@name='email']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='email-error']" should not be visible
    Then I wait for 1 sec
    Then element with xpath "//body" should contain text "Submitted sample form data"
    Examples:
      | email               |
      | "test@example.com"  |
      | "test@ex-ample.com" |
      | "test@example.co-m" |
      | "test@2ch.com"      |
      | "test@ch2.com"      |
      | "test@example.co2"  |
      | "test@1.com"        |
      | "a@example.com"     |
      | "A@example.com"     |
      | "A-a@example.com"   |
      | "A2a@example.com"   |
      | "A.a@example.com"   |

  Scenario Outline: Bad email
    Then I type <email> into element with xpath "//input[@name='email']"
    Then I click on element with xpath "//*[@type='submit']"
    Then element with xpath "//label[@id='email-error']" should be displayed
    Then I wait for 1 sec
    Then element with xpath "//body" should not contain text "Submitted sample form data"
    Examples:
      | email      |
      | "a"        |
      | "@"        |
      | "@."       |
      | " "        |
      | "  "       |
      | " @a.com"  |
      | "a@ .com"  |
      | "a@a.  "   |
      | "a@   "    |
      | "a@"       |
      | "a@a.c"    |
      | "a@a.12"   |
      | "a@a.1c"   |
      | "a@a.c-"   |
      | "a@a.-c"   |
      | "a@-.com"  |
      | "a@-a.com" |
      | "a@a-.com" |
      | "@a.com"   |
      | "a.com"    |
