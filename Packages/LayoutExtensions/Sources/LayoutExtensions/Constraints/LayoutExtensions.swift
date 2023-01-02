import UIKit

public extension UIView {
    @discardableResult func constraintTo(
        leading: AnchorX? = nil,
        top: AnchorY? = nil,
        trailing: AnchorX? = nil,
        bottom: AnchorY? = nil,
        centerX: AnchorX? = nil,
        centerY: AnchorY? = nil,
        width: AnchorDimension? = nil,
        height: AnchorDimension? = nil
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        if let leading {
            constraints += [leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant)]
        }
        
        if let top {
            constraints += [topAnchor.constraint(equalTo: top.anchor, constant: top.constant)]
        }
        
        if let trailing {
            constraints += [trailingAnchor.constraint(equalTo: trailing.anchor, constant: -trailing.constant)]
        }
        
        if let bottom {
            constraints += [bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant)]
        }
        
        if let centerX {
            constraints += [centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.constant)]
        }
        
        if let centerY {
            constraints += [centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.constant)]
        }
        
        if let width {
            if let anchor = width.anchor {
                constraints += [widthAnchor.constraint(equalTo: anchor, multiplier: width.multiplier, constant: width.constant)]
            } else {
                constraints += [widthAnchor.constraint(equalToConstant: width.constant)]
            }
        }
        
        if let height {
            if let anchor = height.anchor {
                constraints += [heightAnchor.constraint(equalTo: anchor, multiplier: height.multiplier, constant: height.constant)]
            } else {
                constraints += [heightAnchor.constraint(equalToConstant: height.constant)]
            }
        }

        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult func constraintTo(
        anchorable: Anchorable,
        leading: CGFloat? = nil,
        top: CGFloat? = nil,
        trailing: CGFloat? = nil,
        bottom: CGFloat? = nil,
        centerX: CGFloat? = nil,
        centerY: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        var leadingAnchor: AnchorX?
        var topAnchor: AnchorY?
        var trailingAnchor: AnchorX?
        var bottomAnchor: AnchorY?
        var centerXAnchor: AnchorX?
        var centerYAnchor: AnchorY?
        
        if let leading {
            leadingAnchor = .init(anchor: anchorable.leadingAnchor, constant: leading)
        }
        
        if let top {
            topAnchor = .init(anchor: anchorable.topAnchor, constant: top)
        }
        
        if let trailing {
            trailingAnchor = .init(anchor: anchorable.trailingAnchor, constant: trailing)
        }

        if let bottom {
            bottomAnchor = .init(anchor: anchorable.bottomAnchor, constant: bottom)
        }
        
        if let centerX {
            centerXAnchor = .init(anchor: anchorable.centerXAnchor, constant: centerX)
        }
        
        if let centerY {
            centerYAnchor = .init(anchor: anchorable.centerYAnchor, constant: centerY)
        }
        
        return constraintTo(
            leading: leadingAnchor,
            top: topAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            centerX: centerXAnchor,
            centerY: centerYAnchor
        )
    }
    
    @discardableResult func constraintToSuperview(
        leading: CGFloat? = nil,
        top: CGFloat? = nil,
        trailing: CGFloat? = nil,
        bottom: CGFloat? = nil,
        centerX: CGFloat? = nil,
        centerY: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        
        return constraintTo(
            anchorable: superview,
            leading: leading,
            top: top,
            trailing: trailing,
            bottom: bottom,
            centerX: centerX,
            centerY: centerY
        )
    }
    
    @discardableResult func constraintToSafeArea(
        leading: CGFloat? = nil,
        top: CGFloat? = nil,
        trailing: CGFloat? = nil,
        bottom: CGFloat? = nil,
        centerX: CGFloat? = nil,
        centerY: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        
        return constraintTo(
            anchorable: superview.safeAreaLayoutGuide,
            leading: leading,
            top: top,
            trailing: trailing,
            bottom: bottom,
            centerX: centerX,
            centerY: centerY
        )
    }
    
    @discardableResult func constraintToMargins(
        leading: CGFloat? = nil,
        top: CGFloat? = nil,
        trailing: CGFloat? = nil,
        bottom: CGFloat? = nil,
        centerX: CGFloat? = nil,
        centerY: CGFloat? = nil
    ) -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        
        return constraintTo(
            anchorable: superview.layoutMarginsGuide,
            leading: leading,
            top: top,
            trailing: trailing,
            bottom: bottom,
            centerX: centerX,
            centerY: centerY
        )
    }
    
    @discardableResult func fillSuperview() -> [NSLayoutConstraint] {
        constraintToSuperview(leading: 0, top: 0, trailing: 0, bottom: 0)
    }
    
    @discardableResult func fillSafeArea() -> [NSLayoutConstraint] {
        constraintToSafeArea(leading: 0, top: 0, trailing: 0, bottom: 0)
    }
    
    @discardableResult func fillMargins() -> [NSLayoutConstraint] {
        constraintToMargins(leading: 0, top: 0, trailing: 0, bottom: 0)
    }
    
    @discardableResult func centerToSuperview() -> [NSLayoutConstraint] {
        constraintToSuperview(centerX: 0, centerY: 0)
    }
    
    @discardableResult func centerToSafeArea() -> [NSLayoutConstraint] {
        constraintToSafeArea(centerX: 0, centerY: 0)
    }
    
    @discardableResult func centerToMargins() -> [NSLayoutConstraint] {
        constraintToSafeArea(centerX: 0, centerY: 0)
    }
}
