import XCTest
@testable import SwiftZulipAPI

class ConfigTests: XCTestCase {
    func testInit() {
        let config = Config(
            emailAddress: "theskunkmb@gmail.com",
            apiKey: "qwertyuiop",
            realmURL: "http://example.com"
        );

        XCTAssertEqual(
            config.emailAddress,
            "theskunkmb@gmail.com",
            "`Config.emailAddress` is incorrect."
        )
        XCTAssertEqual(
            config.apiKey,
            "qwertyuiop",
            "`Config.apiKey` is incorrect."
        )
        XCTAssertEqual(
            config.apiURL,
            "http://example.com/api/v1",
            "`Config.apiURL` is incorrect."
        )
    }
}
