import Foundation

public struct Position {
    let file: File
    let rank: Rank
    
    public init(file: File, rank: Rank) {
        self.file = file
        self.rank = rank
    }
}

extension Position: Equatable { }
extension Position: Hashable { }
