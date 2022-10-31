// Сущность которая хранит и работает со счетом
class ScoreController {
    var score = 0
    func addScore(_ additive: Int) {
        score += additive
    }
    func awardPenalty(_ penalty: Int) {
        score -= penalty
    }
    func reset() {
        score = 0
    }
}
