import XCTest
@testable import ZulipSwift

class MessagesTests: XCTestCase {
    func testSend() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Messages.send`")]

        zulip.messages().send(
            messageType: MessageType.streamMessage,
            to: "test here",
            subject: "Test Message",
            content: "Testing",
            callback: { (response) in
                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testGet() throws {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
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
}
