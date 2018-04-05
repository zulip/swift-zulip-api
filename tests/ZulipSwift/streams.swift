import XCTest
@testable import ZulipSwift

class StreamsTests: XCTestCase {
    func testGetAll() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [
            expectation(description: "`Streams.getAll`"),
            expectation(
                description: "`Streams.getAll` `includePublic: false`"
            ),
            expectation(
                description: "`Streams.getAll` `includeSubscribed: false`"
            ),
            expectation(
                description: "`Streams.getAll` `includeDefault: true`"
            ),
            expectation(
                description: "`Streams.getAll` `includeAllActive: true`"
            ),
        ]

        zulip.streams().getAll(
            callback: { (streams, error) in
                XCTAssertNotNil(
                    streams,
                    "`Streams.getAll` is not successful"
                )
                XCTAssertNil(
                    error,
                    "`Streams.getAll` errors: "
                        + String(describing: error)
                )
                expectations[0].fulfill()
            }
        )
        zulip.streams().getAll(
            includePublic: false,
            callback: { (streams, error) in
                XCTAssertNotNil(
                    streams,
                    "`Streams.getAll` `includePublic: false` is not successful"
                )
                XCTAssertNil(
                    error,
                    "`Streams.getAll` `includePublic: false` errors: "
                        + String(describing: error)
                )
                expectations[1].fulfill()
            }
        )
        zulip.streams().getAll(
            includeSubscribed: false,
            callback: { (streams, error) in
                XCTAssertNotNil(
                    streams,
                    "`Streams.getAll` `includeSubscribed: false` is not "
                        + "successful"
                )
                XCTAssertNil(
                    error,
                    "`Streams.getAll` `includeSubscribed: false` errors: "
                        + String(describing: error)
                )
                expectations[2].fulfill()
            }
        )
        zulip.streams().getAll(
            includeDefault: true,
            callback: { (streams, error) in
                XCTAssertNotNil(
                    streams,
                    "`Streams.getAll` `includeDefault: true` is not successful"
                )
                XCTAssertNil(
                    error,
                    "`Streams.getAll` `includeDefault: true` errors: "
                        + String(describing: error)
                )
                expectations[3].fulfill()
            }
        )
        zulip.streams().getAll(
            includeAllActive: true,
            callback: { (streams, error) in
                /*
                    There should be an error because the test user is not an
                    admin.
                 */
                XCTAssertNil(
                    streams,
                    "`Streams.getAll` `includeAllActive: true` is successful: "
                        + String(describing: streams)
                )
                XCTAssertNotNil(
                    error,
                    "`Streams.getAll` `includeAllActive: true` does not error."
                )
                expectations[4].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
