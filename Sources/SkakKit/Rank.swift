import Foundation

public enum Rank: Int {
    case one, two, three, four, five, six, seven, eight
}

extension Rank: CaseIterable { }
