class CardsController {
    var cardPairs: Int
    var cards: [Card] = []
    var scoreController: ScoreController

    // Инициализация игры
    init(scoreController: ScoreController) {
        cardPairs = 8
        self.scoreController = scoreController
        startGame()
    }

    func chooseCard(cardIndex: Int) {

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
        for i in 0..<cardPairs * 2 {
            cards.append(Card(i, content: i % 2))
        }
    }

    // TODO: протестировать
    func changeLevel(newLevel: Int) {
        cardPairs = newLevel
        startGame()
    }

    // Возможно вынести
    func useTip() {

    }

}

struct Card {
    //var id: Int
    var id: Int
    var contentID: Int
    var isFaceUp: Bool = false

    init(_ i: Int, content: Int){
        id = i
        contentID = content
    }
}