import XCTest
@testable import MemoriseIOSLogic

class ScoreControllerTest: XCTestCase {
    var scoreController: ScoreController = ScoreController()

    func testExample() throws {
        scoreController.addScore(5)

        XCTAssertEqual(scoreController.score, 5)

        scoreController.awardPenalty(3)

        XCTAssertEqual(scoreController.score, 2)

        scoreController.reset()

        XCTAssertEqual(scoreController.score, 0)

    }

}