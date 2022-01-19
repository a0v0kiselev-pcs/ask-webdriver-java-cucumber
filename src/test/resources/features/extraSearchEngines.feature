@extra_search_engines
Feature: Smoke steps

  @extra_search_engines
  Scenario: Gibiru
    Given I open url "https://gibiru.com"
    Then I should see page title as "Gibiru – Protecting your privacy since 2009"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for element with xpath "//div[contains(@class,'gsc-webResult')]" to be present
    Then I wait for 1 sec
    Then element with xpath "//div[contains(@class,'gsc-webResult')]" should contain text "Cucumber"

  @extra_search_engines
  Scenario: DuckDuckGo
    Given I open url "https://duckduckgo.com"
    Then I should see page title as "DuckDuckGo — Privacy, simplified."
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for element with xpath "//div[@id='links']" to be present
    Then I wait for 1 sec
    Then element with xpath "//div[@id='links']" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Swisscows
    Given I open url "https://swisscows.com"
    Then I should see page title as "Swisscows the alternative, data secure search engine."
    Then element with xpath "//input[@name='query']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='query']"
    Then I click on element using JavaScript with xpath "//button[@class='search-submit']"
    Then I wait for element with xpath "//div[@class='web-results']" to be present
    Then element with xpath "//div[@class='web-results']" should contain text "Cucumber"

  @extra_search_engines
  Scenario: SearchEncrypt
    Given I open url "https://www.searchencrypt.com"
    Then I should see page title as "Search Encrypt | Home"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for 1 sec
    Then I wait for element with xpath "//section[contains(@class,'serp__results')]" to be present
    Then I wait for 1 sec
    Then element with xpath "//section[contains(@class,'serp__results')]" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Startpage
    Given I open url "https://www.startpage.com"
    Then I should see page title as "Startpage - Private Search Engine. No Tracking. No Search History."
    Then element with xpath "(//input[@name='query'])[1]" should be present
    When I type "Behavior Driven Development" into element with xpath "(//input[@name='query'])[1]"
    Then I click on element using JavaScript with xpath "(//*[@type='submit' and ./ancestor::form/@role='search'])[1]"
    Then I wait for element with xpath "//section[contains(@class,'w-gl ')]//a" to be present
    Then I wait for 1 sec
    Then element with xpath "//section[contains(@class,'w-gl ')]" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Yandex
    Given I open url "https://www.yandex.com"
    Then I should see page title as "Yandex"
    Then element with xpath "//input[@name='text']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='text']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for element with xpath "//*[@id='search-result']" to be present
    Then element with xpath "//*[@id='search-result']" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Ecosia
    Given I open url "https://www.ecosia.org"
    Then I should see page title as "Ecosia - the search engine that plants trees"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for element with xpath "//main" to be present
    Then element with xpath "//main" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Wiki
    Given I open url "https://www.wiki.com"
    Then I should see page title as "Wiki.com"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I accept form action over HTTP
    Then I wait for element with xpath "//iframe" to be present
    Then I switch to iframe with xpath "//iframe"
    Then I wait for element with xpath "//div[contains(@class,'gsc-results')]" to be present
    Then I wait for 1 sec
    Then element with xpath "//div[contains(@class,'gsc-results')]" should contain text "Cucumber"

  @extra_search_engines
  Scenario: giveWater
    Given I open url "https://www.givewater.com/"
    Then I should see page title as "Search the Web to Give Clean Water to Those in Need » giveWater Search Engine"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@type='submit']"
    Then I wait for element with xpath "//div[@class='web-bing']" to be present
    Then element with xpath "//div[@class='web-bing']" should contain text "Cucumber"

  @extra_search_engines
  Scenario: Ekoru
    Given I open url "https://ekoru.org/"
    Then I should see page title as "Ekoru - every search cleans our oceans"
    Then element with xpath "//input[@name='q']" should be present
    When I type "Behavior Driven Development" into element with xpath "//input[@name='q']"
    Then I click on element using JavaScript with xpath "//*[@onclick='search()']"
    Then I wait for element with xpath "//div[@id='div_results']" to be present
    Then element with xpath "//div[@id='div_results']" should contain text "Cucumber"
