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
            callback: { (id, messageError) in
                XCTAssertNotNil(
                    id,
                    "`Messages.send` is not successful"
                )
                XCTAssertNil(
                    messageError,
                    "`Messages.send` errors."
                )
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
                XCTAssert(
                    response.result.isSuccess,
                    "`Messages.get` is not successful"
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
            callback: { (response) in
                XCTAssert(
                    response.result.isSuccess,
                    "`Messages.render` is not successful"
                )

                guard
                    let responseValue = response.result.value,
                    let responseDictionary = responseValue
                        as? Dictionary<String, Any>,
                    let responseRendered = responseDictionary["rendered"]
                        as? String
                else {
                    XCTFail("`Message.render`'s response value was `nil`.'")
                    return
                }

                XCTAssertEqual(
                    "<p>Testing, <strong>testing</strong>, <span "
                        + "class=\"emoji emoji-1f603\" title=\"smiley\">"
                        + ":smiley:</span>.</p>",
                    responseRendered,
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
            to: "test here",
            subject: "Test Message",
            content: "Testing",
            callback: { (response) in
                guard
                    let responseValue = response.result.value,
                    let responseDictionary = responseValue
                        as? Dictionary<String, Any>,
                    let responseID = responseDictionary["id"] as? Int
                else {
                    XCTFail("`Message.send`'s response value was `nil`.'")
                    return
                }

                zulip.messages().update(
                    messageID: responseID,
                    content: "Test Update",
                    callback: { (response) in
                        XCTAssert(
                            response.result.isSuccess,
                            "`Messages.update` is not successful"
                        )
                        expectations[0].fulfill()
                    }
                )
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
