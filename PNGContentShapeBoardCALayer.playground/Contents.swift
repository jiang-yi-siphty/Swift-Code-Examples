//: A UIKit based Playground to present user interface
  
import UIKit
import XCPlayground
import PlaygroundSupport
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 540))
let image = UIImage(named: "otherAirplane.png")
let widthInPoints = image?.size.width
let heightInPoints = image?.size.height
let imageFrame = CGRect(x: 0, y: 0, width: widthInPoints!, height: heightInPoints!)

let view = UIView(frame: imageFrame)
view.backgroundColor = UIColor.white

let view2 = UIView(frame: CGRect(x: 0, y: 300, width: widthInPoints!, height: heightInPoints!))

extension CALayer{
    func doMask(by imageMask: UIImage) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: imageMask.size.width, height: imageMask.size.height)
        maskLayer.contents = imageMask.cgImage
        maskLayer.frame = bounds
        mask = maskLayer
    }
    
    func doMask2(by imageMask: UIImage) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.contents = imageMask.cgImage
        maskLayer.contentsGravity = kCAGravityResizeAspect
        maskLayer.frame = frame
        mask = maskLayer
    }
    
}

let shadowView: UIView = {
    let shadowView = UIView(frame: view.frame)
    shadowView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    shadowView.layer.doMask(by: UIImage(named: "otherAirplane.png")!)
    let boardLayer = CALayer()
    boardLayer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor
    boardLayer.frame = CGRect(x: 3, y: 2, width: shadowView.frame.width - 12, height: shadowView.frame.height - 8)
    boardLayer.doMask2(by: UIImage(named: "otherAirplane.png")!)
    shadowView.layer.addSublayer(boardLayer)
    print(Int((shadowView.layer.sublayers?.count)!))
    return shadowView
}()


view.addSubview(shadowView)
view.contentMode = UIViewContentMode.center


PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
