import XCTest
@testable import SwiftZulipAPIBots

class EchoBotTests: XCTestCase {
    func testHandleMessage() {
        let echoBot = EchoBot(config: [:])

        let expectations = [expectation(description: "`EchoBot.handleMessage`")]

        echoBot.handleMessage(
            message: [:],
            contentWithoutMention: "Testing, 123",
            callback: { (content, error) in
                XCTAssertNotNil(
                    content,
                    "`EchoBot.handleMessage` is not successful"
                )
                XCTAssertEqual(
                    "Testing, 123",
                    content,
                    "`EchoBot.handleMessage` does not reverse correctly."
                )
                XCTAssertNil(
                    error,
                    "`EchoBot.handleMessage` errors: "
                        + String(describing: error)
                )

                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
