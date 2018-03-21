//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport


var str = "Hello, playground"

let scaleColor = UIColor.init(red: 35.0 / 255.0,
                              green: 210.0 / 255.0,
                              blue: 35.0 / 255.0,
                              alpha: 1).cgColor
let pixlesTimes: CGFloat = 1.0

extension CALayer{
    
    /// Disable animation
    ///
    /// - Parameter actionsWithoutAnimation: block of the actions
    class func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void){
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
    
    func doMask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        mask = maskLayer
    }
    
    func doMask(withPath path: UIBezierPath, inverse: Bool = false) {
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        mask = maskLayer
    }
    
    func drawLine(fromPoint start: CGPoint, toPoint end:CGPoint, width: Int){
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.lineWidth = CGFloat(width) * pixlesTimes
        line.strokeColor =  scaleColor
        addSublayer(line)
    }
}


let view = UIView(frame: CGRect(x: 0, y: 0, width: 473 * pixlesTimes, height: 31 * pixlesTimes))



