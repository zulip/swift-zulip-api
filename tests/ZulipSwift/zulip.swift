import XCTest
@testable import ZulipSwift

class ZulipTests: XCTestCase {
    func testInit() {
        let config = Config(
            emailAddress: "theskunkmb@gmail.com",
            apiKey: "qwertyuiop",
            realmURL: "http://example.com"
        );
        let zulip = Zulip(config: config)

        XCTAssert(
            zulip.config === config,
            "`Zulip.config` is incorrect."
        )
    }

    func testMessages() {
        let config = Config(
            emailAddress: "theskunkmb@gmail.com",
            apiKey: "qwertyuiop",
            realmURL: "http://example.com"
        );
        let zulip = Zulip(config: config)
        let messages = zulip.messages()

        XCTAssert(
            type(of: messages) == Messages.self,
            "`type(of: Zulip.messages())` is incorrect."
        )
    }
}
