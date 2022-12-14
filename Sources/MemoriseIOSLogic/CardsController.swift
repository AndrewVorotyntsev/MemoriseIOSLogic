import Foundation

class CardsController {
    var cardPairs: Int
    var cards: [Card] = []
    var scoreController: ScoreController

    var amountOfTips: Int

    var choosenCardIndex: Int?

    // Инициализация игры
    init(scoreController: ScoreController) {
        // Игра начинается со случайного количества карта от 2 до 5
        cardPairs = Int.random(in: 2..<5)
        self.scoreController = scoreController
        // Ограничиваем количество подсказок одной
        amountOfTips = 1
        startGame()
    }

    func chooseCard(cardIndex: Int) {
        if (choosenCardIndex == nil) {
            choosenCardIndex = cardIndex
            // перевернуть карту
            cards.first(where: {$0.id == cardIndex})?.turn()
        } else {
            let firstCard = cards.first(where: {$0.id == choosenCardIndex})
            let secondCard = cards.first(where: {$0.id == cardIndex})
            secondCard?.turn()
            if (firstCard?.contentID == secondCard?.contentID) {
                // Добавляем два очка за сопадение
                scoreController.addScore(2)
                firstCard?.guess()
                secondCard?.guess()
            } else {
                // Штраф за несовпадение
                scoreController.awardPenalty(1)
                firstCard?.turn()
                secondCard?.turn()
            }
            choosenCardIndex = nil
        }

    }

    func startGame() {
        initCards()
        shuffleCard()
        scoreController.reset()
    }

    func shuffleCard() {
        cards.shuffle()
    }

    // Создает список упорядоченных карт
    private func initCards() {
        cards = []
        for i in 0..<cardPairs * 2 {
            cards.append(Card(i, content: i % 2))
        }
    }

    func changeDifficulty(newDifficulty: Int) {
        cardPairs = newDifficulty
        startGame()
    }

    func useTip() {
        if (amountOfTips > 0) {
            turnAllCard()
            sleep(5)
            turnAllCard()
            // При использовании подсказки начислить штрафные 5 очков
            scoreController.awardPenalty(5) 
        }
    }

    func turnAllCard() {
        for i in 0..<cardPairs * 2 {
            cards[i].turn()
        }
    }

}

class Card {
    var id: Int
    var contentID: Int
    var isFaceUp: Bool
    var isGuessed: Bool

    init(_ i: Int, content: Int){
        id = i
        contentID = content
        isFaceUp = false
        isGuessed = false
    }

    func turn() {
        isFaceUp = !isFaceUp
    }

    func guess() {
        isGuessed = !isGuessed
    }
}