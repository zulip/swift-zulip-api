import XCTest
@testable import ZulipSwift

class MessagesTests: XCTestCase {
    func testGet() throws {
        guard let zulip = self.getZulip() else {
            return
        }

        let expectations = [expectation(description: "`Messages.get`")]

        try zulip.messages().get(
            narrow: [["stream", "test here"]],
            anchor: 391920,
            amountBefore: 13,
            amountAfter: 13,
            callback: { (response) in
                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func getZulip() -> Zulip? {
        let environmentVariables = ProcessInfo.processInfo.environment

        guard
            let testEmailAddress = environmentVariables["emailAddress"]
        else {
            XCTFail("No `emailAddress` was set.")
            return nil
        }

        guard let testAPIKey = environmentVariables["apiKey"] else {
            XCTFail("No `apiKey` was set.")
            return nil
        }

        guard let testRealmURL = environmentVariables["realmURL"] else {
            XCTFail("No `realmURL` was set.")
            return nil
        }

        let config = Config(
            emailAddress: testEmailAddress,
            apiKey: testAPIKey,
            realmURL: testRealmURL
        )

        return Zulip(config: config)
    }
}
