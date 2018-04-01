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
}
