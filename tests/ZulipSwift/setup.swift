import XCTest
@testable import ZulipSwift

public func getZulip() -> Zulip? {
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
