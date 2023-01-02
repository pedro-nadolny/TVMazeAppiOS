import UIKit

public struct AnchorX {
    let anchor: NSLayoutXAxisAnchor
    let constant: CGFloat
    
    public init(anchor: NSLayoutXAxisAnchor, constant: CGFloat = .zero) {
        self.anchor = anchor
        self.constant = constant
    }
}

public struct AnchorY {
    let anchor: NSLayoutYAxisAnchor
    let constant: CGFloat
    
    public init(anchor: NSLayoutYAxisAnchor, constant: CGFloat = .zero) {
        self.anchor = anchor
        self.constant = constant
    }
}

public struct AnchorDimension {
    let anchor: NSLayoutDimension?
    let multiplier: CGFloat
    let constant: CGFloat
    
    public init(anchor: NSLayoutDimension? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = .zero) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
    }
}
