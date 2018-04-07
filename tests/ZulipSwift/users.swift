import XCTest
@testable import ZulipSwift

class UsersTests: XCTestCase {
    func testGetAll() {
        guard let zulip = getZulip() else {
            XCTFail("Zulip could not be configured.")
            return
        }

        let expectations = [expectation(description: "`Users.getAll`")]

        zulip.users().getAll(
            clientGravatar: false,
            callback: { (members, messageError) in
                XCTAssertNotNil(
                    members,
                    "`Users.getAll` is not successful"
                )
                XCTAssertNil(
                    messageError,
                    "`Users.getAll` errors: "
                        + String(describing: messageError)
                )

                expectations[0].fulfill()
            }
        )

        wait(for: expectations, timeout: 60)
    }
}
