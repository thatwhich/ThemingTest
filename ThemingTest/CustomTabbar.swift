//
//  CustomTabbar.swift
//  ThemingTest
//
//  Created by admin on 18.10.21.
//

import UIKit

class TabBarWithCorners: UITabBar {
    let shadowColor = UIColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 0.05)
    let radii: CGFloat = 40.0
    
    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.white.cgColor
        
        //shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        //shapeLayer.lineWidth = 0
        
        shapeLayer.shadowColor = shadowColor.cgColor
        shapeLayer.shadowOffset = CGSize(width: -2, height: -10);
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topRight], //.topLeft,
            cornerRadii: CGSize(width: radii, height: 0.0)
        )
        return path.cgPath
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        let win = UIApplication.shared.windows.first
        
        tabFrame.size.height = 65 + (win?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y = self.frame.origin.y + (self.frame.height - 65 - (win?.safeAreaInsets.bottom ?? CGFloat.zero))
        self.layer.cornerRadius = radii
        self.frame = tabFrame

        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }

}

