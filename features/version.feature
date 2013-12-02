Feature: cli/version

    Scenario: Getting the commitsu version
      When I run `commitsu version`
      Then the exit status should be 0
      And the output should match /commitsu v[0-9]+\.[0-9]\.+[0-9]+/
