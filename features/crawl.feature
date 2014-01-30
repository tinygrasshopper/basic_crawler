Feature: Crawl

  Scenario: Crawl website for input counts
    When I execute the crawler for site "http://example.com/non_existant"
    Then It should give the following output on the console
      | line                      |
      | /page_1.html  - 5 inputs  |
      | /page_2.html  - 13 inputs |
      | /page_3.html  - 2 inputs  |

