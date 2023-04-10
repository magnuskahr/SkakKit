import Foundation

protocol BoardBuilder {
    func construct() -> [Position: Piece]
}
