Feature: Users
  Background:
    Given the following users exists:
        | partner_token | first_name  | email           |
        | 123           | foozie      | foozie@test.com |
        | 321           | barzie      | barzie@test.com |

  Scenario: Create User
    When I send a POST request to /users.json with the following:
      """
      {
        "user" : {
          "pass" : "other",
          "pass_confirmation" : "other",
          "token" : "sluggy",
          "first_name" : "harry",
          "last_name" : "gibbon"
          }
      }
      """
    Then the status code should be 201

