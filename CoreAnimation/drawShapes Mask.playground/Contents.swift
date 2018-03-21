//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 540))
let image = UIImage(named: "DJI P4.png")
let widthInPoints = image?.size.width
let heightInPoints = image?.size.height
let imageFrame = CGRect(x: 0, y: 0, width: widthInPoints!, height: heightInPoints!)

let view = UIView(frame: imageFrame)
view.backgroundColor = UIColor.white


extension CALayer{
    func doMask(withPath path: UIBezierPath, inverse: Bool = false) {
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        maskLayer.path = path.cgPath
        mask = maskLayer
    }
    
    
    func doMask(by imageMask: UIImage) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: imageMask.size.width, height: imageMask.size.height)
        maskLayer.contents = imageMask.cgImage
//        maskLayer.contents = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        maskLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        mask = maskLayer
    }
}

let shadowView: UIView = {
    let shadowView = UIView(frame: view.frame)
    shadowView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    shadowView.layer.doMask(by: UIImage(named: "DJI P4.png")!)
    return shadowView
}()

view.addSubview(shadowView)
view.contentMode = UIViewContentMode.center


PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true



