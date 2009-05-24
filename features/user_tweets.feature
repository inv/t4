Feature: Show users tweets
  In order to see all his tweets
  the user
  wants to see all his tweets
  
  Scenario: A user clicks on his twitter profile
    Given there is a twitter user called 'jcfischer'
    And he has tweets
    And I go to the homepage
    And I follow "jcfischer"
    Then I should see a list of tweets
