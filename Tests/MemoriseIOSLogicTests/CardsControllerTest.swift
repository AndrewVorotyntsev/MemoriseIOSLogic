import XCTest
@testable import MemoriseIOSLogic

class CardsControllerTest: XCTestCase {
    var scoreController: ScoreController = ScoreController()
    var cardsController: CardsController?

    override func setUp() {
        cardsController = CardsController(scoreController: scoreController)
    }


    func testExample() throws {
        testStartGame()

        testShuffleCards()


        testChooseCard()

        // Проверка смены уровня сложности
        cardsController!.changeLevel(newLevel: 16)
        XCTAssertEqual(cardsController?.cardPairs, 16, "Изменен уровень сложности")
        testStartGame()

    }

    // Проверка начала игры
    fileprivate func testStartGame() {
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
    }

    // Проверка перемешивания карт
    fileprivate func testShuffleCards() {
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

    // Проверка выбора карты
    fileprivate func testChooseCard() {
        cardsController?.chooseCard(cardIndex: 0)
        XCTAssertEqual(cardsController?.cards.first(where: {$0.id == 0})?.isFaceUp, true,
        "Выбранная карта должны быть перевернута")
        // Тестирование совпадения
        let firstCard = cardsController?.cards.first(where: {$0.id == 0})
        let secondCard = cardsController?.cards.first(where: {$0.contentID == firstCard?.contentID})
        cardsController?.chooseCard(cardIndex: secondCard!.id)
        XCTAssertEqual(cardsController?.cards.first(where: {$0.id == secondCard!.id})?.isFaceUp, true,
        "Вторая выбранная карта должны быть перевернута")
        XCTAssertEqual(scoreController.score, 2, "Счет увеличивается на 2")
        XCTAssertEqual(cardsController?.cards.first(where: {$0.id == 0})?.isGuessed, true, "Первая карта должны быть угадана")
        XCTAssertEqual(cardsController?.cards.first(where: {$0.id == secondCard!.id})?.isGuessed, true, "Вто карта должны быть угадана")
    }

}