//
//  WaterButton.swift
//  nutritionapp
//
//  Created by Minguell, Tomas P on 4/26/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit

@IBDesignable
class WaterButton: UIButton {
    
    @IBInspectable var isAddButton: Bool = true
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let waterButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        
        let borderColor = UIColor.black
        borderColor.setStroke()
        
        path.lineWidth = 2.0
        
        path.fill()
        path.stroke()
        
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.waterButtonScale
        let halfPlusWidth = plusWidth / 2
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = Constants.plusLineWidth
        
        plusPath.move(to: CGPoint(
            x: halfWidth - halfPlusWidth + Constants.halfPointShift,
            y: halfHeight + Constants.halfPointShift))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + halfPlusWidth + Constants.halfPointShift,
            y: halfHeight + Constants.halfPointShift))
        
        if isAddButton {
            plusPath.move(to: CGPoint(
                x: halfWidth + Constants.halfPointShift,
                y: halfHeight - halfPlusWidth + Constants.halfPointShift))
            
            plusPath.addLine(to: CGPoint(
                x: halfWidth + Constants.halfPointShift,
                y: halfHeight + halfPlusWidth +  Constants.halfPointShift))
        }
        
        UIColor.black.setStroke()
        plusPath.stroke()
    }

}
