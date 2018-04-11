import XCTest
@testable import SwiftZulipAPI

class MessagesTests: XCTestCase {
    func testSend() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Messages.send`")]

        zulip.messages().send(
            messageType: MessageType.streamMessage,
            to: "zulip-swift-tests",
            subject: "CI Tests",
            content: "Testing",
            callback: { (id, messageError) in
                XCTAssertNotNil(
                    id,
                    "`Messages.send` is not successful"
                )
                XCTAssertNil(
                    messageError,
                    "`Messages.send` errors: "
                        + String(describing: messageError)
                )
                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testGet() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Messages.get`")]

        zulip.messages().get(
            narrow: [["stream", "zulip-swift-tests"]],
            anchor: 391920,
            amountBefore: 13,
            amountAfter: 13,
            callback: { (messages, messageError) in
                XCTAssertNotNil(
                    messages,
                    "`Messages.get` is not successful"
                )
                XCTAssertNil(
                    messageError,
                    "`Messages.get` errors: "
                        + String(describing: messageError)
                )
                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testRender() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Messages.render`")]

        zulip.messages().render(
            content: "Testing, **testing**, :smiley:.",
            callback: { (rendered, messageError) in
                XCTAssertNotNil(
                    rendered,
                    "`Messages.render` is not successful"
                )
                XCTAssertNil(
                    messageError,
                    "`Messages.render` errors: "
                        + String(describing: messageError)
                )

                XCTAssertEqual(
                    "<p>Testing, <strong>testing</strong>, <span "
                        + "class=\"emoji emoji-1f603\" title=\"smiley\">"
                        + ":smiley:</span>.</p>",
                    rendered,
                    "`Messages.render` did not render correctly."
                )

                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testUpdates() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Messages.update`")]

        zulip.messages().send(
            messageType: MessageType.streamMessage,
            to: "zulip-swift-tests",
            subject: "CI Tests",
            content: "Testing",
            callback: { (id, messageError) in
                guard let id = id else {
                    XCTFail("`Message.send`'s `id` was `nil`.'")
                    return
                }

                zulip.messages().update(
                    messageID: id,
                    content: "Test Update",
                    callback: { (messageError) in
                        XCTAssertNil(
                            messageError,
                            "`Messages.update` errors: "
                                + String(describing: messageError)
                        )

                        expectations[0].fulfill()
                    }
                )
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
