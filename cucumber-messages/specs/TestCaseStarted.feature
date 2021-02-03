Feature: Sending TestCaseStarted Messages

    - Message is send before all BeforeScenario hooks
    - Timestamp is in local time zone

    Scenario Outline: Starting test cases sends a message per test case

        Given there are '<NumberOfScenarios>' scenarios
        When the test suite is executed
        Then '<NumberOfTestCaseStartedMessages>' TestCaseStarted messages have been sent

        Examples:
          | Case             | NumberOfScenarios | NumberOfTestCaseStartedMessages |
          | empty test suite | 0                 | 0                               |
          | Single scenario  | 1                 | 1                               |
          | Two scenarios    | 2                 | 2                               |

    Scenario: Test case start time and PickleId is included in the message

        Given there is a scenario with PickleId 'ff981b6f-b11e-4149-baa1-9794940ac8bf'
        When the scenario is started at '2019-05-13 13:09:46'
        Then a TestCaseStarted message has been sent with the following attributes
          | Attribute | Value                                |
          | pickleId  | ff981b6f-b11e-4149-baa1-9794940ac8bf |
          | timestamp | '2019-05-13 13:09:46'                |

    Scenario Outline: Cucumber implementation and version is included in the message

        Given the cucumber implementation '<Implementation>'
        When the test suite is executed
        Then a TestCaseStarted message has been sent with the following platform information
          | Attribute      | Value            |
          | implementation | <Implementation> |
        And the TestCaseStarted message contains the following platform information attributes
          | Attribute |
          | version   |
          | os        |
          | cpu       |
        
		@SpecFlow
        Examples:
          | Implementation |
          | SpecFlow       |
