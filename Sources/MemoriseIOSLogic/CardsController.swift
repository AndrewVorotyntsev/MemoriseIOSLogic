class CardsController {
    var cardPairs: Int
    var cards: [Card] = []
    var scoreController: ScoreController

    var choosenCardIndex: Int?

    // Инициализация игры
    init(scoreController: ScoreController) {
        cardPairs = 8
        self.scoreController = scoreController
        startGame()
    }

    func chooseCard(cardIndex: Int) {
        if (choosenCardIndex != nil) {
            choosenCardIndex = cardIndex
            // перевернуть карту
            cards.first(where: {$0.id == cardIndex})?.isFaceUp = true
        } else {
            let firstCard = cards.first(where: {$0.id == choosenCardIndex})
            let secondCard = cards.first(where: {$0.id == cardIndex})
            secondCard?.isFaceUp = true
            if (firstCard?.contentID == secondCard?.contentID) {
                scoreController.addScore(2)
                firstCard?.isGuessed = true
                secondCard?.isGuessed = true
            } else {
                scoreController.awardPenalty(1)
                firstCard?.isFaceUp = false
                secondCard?.isFaceUp = false
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

    private func initCards() {
        cards = []
        for i in 0..<cardPairs * 2 {
            cards.append(Card(i, content: i % 2))
        }
    }

    func changeLevel(newLevel: Int) {
        cardPairs = newLevel
        startGame()
    }

    // Возможно вынести
    func useTip() {

    }

}

class Card {
    var id: Int
    var contentID: Int
    var isFaceUp: Bool = false
    var isGuessed: Bool = false

    init(_ i: Int, content: Int){
        id = i
        contentID = content
    }
}