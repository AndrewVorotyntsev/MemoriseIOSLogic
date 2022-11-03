import XCTest
@testable import MemoriseIOSLogic

class CardTest: XCTestCase {
    var card = Card(0 , content: 0)
    var cardList = [Card(0 , content: 0), Card(1 , content: 1)]

    override func setUp() {
        
    }


    func testExample() throws {
        // Тестирование переворота карты
        XCTAssertEqual(card.isFaceUp, false, "Изначально карта должны быть не перевернута")
        card.turn()
        XCTAssertEqual(card.isFaceUp, true, "Карта перевернута")

        // Тестирование угадывания карты
        XCTAssertEqual(card.isGuessed, false, "Изначально карта должны быть не угадана")
        card.guess()
        XCTAssertEqual(card.isGuessed, true, "Карта угадана")

        // Тестирование переворота карты в массиве
        XCTAssertEqual(cardList[0].isFaceUp, false, "Изначально карта в массиве должны быть не перевернута")
        cardList[0].turn()
        XCTAssertEqual(cardList[0].isFaceUp, true, "Карта в массиве перевернута")

        // Тестирование угадывания карты в массиве
        XCTAssertEqual(cardList[0].isGuessed, false, "Изначально карта в массиве должны быть не угадана")
        cardList[0].guess()
        XCTAssertEqual(cardList[0].isGuessed, true, "Карта в массиве угадана")
    }
}