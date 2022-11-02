import XCTest
@testable import MemoriseIOSLogic

class CardsControllerTest: XCTestCase {
    var scoreController: ScoreController = ScoreController()
    var cardsController: CardsController?

    override func setUp() {
        cardsController = CardsController(scoreController: scoreController)
    
    }

    func testExample() throws {
        // Проверка количества карт
        XCTAssertEqual(cardsController!.cards.count, cardsController!.cardPairs * 2,
        "Проверка количества карт")

        // Проверка счета в начале игры
        XCTAssertEqual(scoreController.score, 0, "В начале игры счет 0")

        // Проверка наличия всех необходимых карт
        for i in 0..<cardsController!.cardPairs {
            XCTAssertEqual(cardsController!.cards.contains{
                item in 
                if (item.id == i && item.contentID == i % 2) {
                    return true
                } else {
                    return false
                }
            }, true, "Проверка наличия всех необходимых карт"
            )
        }

        // Проверка перемешивания карт
        // Карты до перемешивания
        let cardsBeforeShuffling = cardsController?.cards
        // Перемешиваем карты
        cardsController?.shuffleCard()
        // Карты после перемешивания
        let cardsAfterShuffling = cardsController?.cards
        // Результаты сравнения - сравниваем каждую карту с каждой
        var comparationResult: [Bool] = []
        for i in 0..<cardsController!.cardPairs {
            if (cardsBeforeShuffling?[i].contentID == cardsAfterShuffling?[i].contentID) {
                comparationResult.append(true)
            } else {
                comparationResult.append(false)
            }
        }
        // Необходимо чтобы хотя бы две карты не совпали
        XCTAssertEqual(comparationResult.contains(false) , true, "Карты должны быть перемешаны")
    }

}