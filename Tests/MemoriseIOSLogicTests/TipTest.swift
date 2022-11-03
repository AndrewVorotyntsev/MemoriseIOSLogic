import XCTest
@testable import MemoriseIOSLogic

class TipTest: XCTestCase {
    var scoreController: ScoreController = ScoreController()
    var cardsController: CardsController?

    override func setUp() {
        cardsController = CardsController(scoreController: scoreController)
    }


    func testExample() async throws  {
        cardsController!.startGame()
        await cardsController!.useTip()
        for i in 0..<cardsController!.cardPairs * 2 {
            XCTAssertEqual(cardsController!.cards[i].isFaceUp, false, "Карта скрыта для пользователя")
        }
        XCTAssertEqual(scoreController.score, -5, "счет уменьшился на 5")
    }

}