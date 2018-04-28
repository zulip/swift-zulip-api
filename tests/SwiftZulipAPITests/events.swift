import XCTest
@testable import SwiftZulipAPI

class EventsTests: XCTestCase {
    func testRegister() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [
            expectation(description: "`Events.register`"),
            expectation(
                description: "`Events.register` `applyMarkdown: true`"
            ),
            expectation(
                description: "`Events.register` `clientGravatar: true`"
            ),
            expectation(
                description: "`Events.register` `allPublicStreams: true`"
            ),
            expectation(
                description: "`Events.register` `includeSubscribers: true`"
            ),
        ]

        zulip.events().register(
            eventTypes: ["messages"],
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                XCTAssertNotNil(
                    queue,
                    "`Events.register` is not successful"
                )
                XCTAssertNil(
                    error,
                    "`Events.register` errors: "
                        + String(describing: error)
                )

                expectations[0].fulfill()
            }
        )

        zulip.events().register(
            applyMarkdown: true,
            eventTypes: ["messages"],
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                XCTAssertNotNil(
                    queue,
                    "`Events.register` `applyMarkdown: true` is not successful"
                )
                XCTAssertNil(
                    error,
                    "`Events.register` `applyMarkdown: true` errors: "
                        + String(describing: error)
                )

                expectations[1].fulfill()
            }
        )

        zulip.events().register(
            clientGravatar: true,
            eventTypes: ["messages"],
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                XCTAssertNotNil(
                    queue,
                    "`Events.register` `clientGravatar: true` is not "
                        + "successful"
                )
                XCTAssertNil(
                    error,
                    "`Events.register` `clientGravatar: true` errors: "
                        + String(describing: error)
                )

                expectations[2].fulfill()
            }
        )

        zulip.events().register(
            eventTypes: ["messages"],
            allPublicStreams: true,
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                XCTAssertNotNil(
                    queue,
                    "`Events.register` `allPublicStreams: true` is not "
                        + "successful"
                )
                XCTAssertNil(
                    error,
                    "`Events.register` `allPublicStreams: true` errors: "
                        + String(describing: error)
                )

                expectations[3].fulfill()
            }
        )

        zulip.events().register(
            eventTypes: ["messages"],
            includeSubscribers: true,
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                XCTAssertNotNil(
                    queue,
                    "`Events.register` `includeSubscribers: true` is not "
                        + "successful"
                )
                XCTAssertNil(
                    error,
                    "`Events.register` `includeSubscribers: true` errors: "
                        + String(describing: error)
                )

                expectations[4].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testGet() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Events.get`")]

        zulip.events().register(
            eventTypes: ["messages"],
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                guard
                    let queue = queue,
                    let queueID = queue["queue_id"] as? String
                else {
                    XCTFail("`Events.register`'s `queue` was `nil`.'")
                    return
                }

                zulip.events().get(
                    queueID: queueID,
                    lastEventID: -1,
                    dontBlock: true,
                    callback: { (events, error) in
                        XCTAssertNotNil(
                            events,
                            "`Events.get` is not successful."
                        )
                        XCTAssertNil(
                            error,
                            "`Events.get` errors: "
                                + String(describing: error)
                        )

                        expectations[0].fulfill()
                    }
                )
            }
        )

        wait(for: expectations, timeout: 60)
    }

    func testDeleteQueue() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Events.deleteQueue`")]

        zulip.events().register(
            eventTypes: ["messages"],
            narrow: [["stream", "zulip-swift-tests"]],
            callback: { (queue, error) in
                guard
                    let queue = queue,
                    let queueID = queue["queue_id"] as? String
                else {
                    XCTFail("`Events.register`'s `queue` was `nil`.'")
                    return
                }

                zulip.events().deleteQueue(
                    queueID: queueID,
                    callback: { (error) in
                        XCTAssertNil(
                            error,
                            "`Events.get` errors: "
                                + String(describing: error)
                        )

                        expectations[0].fulfill()
                    }
                )
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
