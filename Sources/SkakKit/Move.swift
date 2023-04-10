import Foundation

struct Move {
    
    let from: Position
    let to: Position
    
    var isDiagonal: Bool {
        abs(from.file.rawValue - to.file.rawValue) == abs(from.rank.rawValue - to.rank.rawValue)
    }
    
    var isHorizontal: Bool {
        from.rank == to.rank
    }
    
    var isVertical: Bool {
        from.file == to.file
    }
}
