import Foundation

public protocol SearchItem {
    var score: Double { get }
    var show: Show { get }
}
