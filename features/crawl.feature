Feature: Crawl

  Scenario: Crawl website for input counts
    When I execute the crawler for site "http://example.com/non_existant/page_1.html"
    Then It should give the following output on the console
      | line                      |
      | /page_1.html  - 15 inputs  |
      | /page_2.html  - 10 inputs |
      | /page_3.html  - 6 inputs  |

