//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport


//Configuration
let scaleColor = UIColor.init(red: 35.0 / 255.0,
                              green: 210.0 / 255.0,
                              blue: 35.0 / 255.0,
                              alpha: 1).cgColor
let pixlesTimes: CGFloat = 1.0
let isFacingNorth: Bool = false


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


var didSetup = false
var shortScalePixels: CGFloat = 10.0 * pixlesTimes
var longScalePixels: CGFloat = 16.0 * pixlesTimes
var pixelPerUnit: CGFloat = 10.48 * pixlesTimes
var unitPerShortScale: Int = 1
var unitPerLongScale: Int = 10
var unitPerLabel: Int = 10
var labelHeight: CGFloat = 14.0 * pixlesTimes
var unitPerCardinal: Int = 90
var hasUnderline: Bool = true
var hasTopline: Bool = true



let view = UIView(frame: CGRect(x: 0, y: 0, width: 473 * pixlesTimes, height: 31 * pixlesTimes))
//view.backgroundColor = UIColor.yellow



//Heading Tape Layer
let headingTape = CALayer()
headingTape.frame = CGRect(x: -179.0 * pixelPerUnit, y: 0.0, width: pixelPerUnit * 360.0  * pixlesTimes, height: 31 * pixlesTimes)
headingTape.borderColor = UIColor.red.cgColor
headingTape.borderWidth = 1
headingTape.backgroundColor = UIColor.blue.cgColor

headingTape.sublayers?.forEach { $0.removeFromSuperlayer() }
let extraHeight = (headingTape.frame.height - (labelHeight + 1.0 + longScalePixels))
longScalePixels = longScalePixels + extraHeight
shortScalePixels = shortScalePixels + extraHeight
let longShortDif = (longScalePixels - shortScalePixels) / 2
for i in 0 ... 360 {
    // Draw scale lines (both long and short lines)
    if (i % unitPerLongScale) == 0 {
        let n = i / unitPerLongScale
        let scalePositionX = CGFloat(n * unitPerLongScale) * pixelPerUnit
        let startPoint = CGPoint(x: scalePositionX, y: labelHeight + 1)
        let endPoint = CGPoint(x: scalePositionX, y: labelHeight + 1.0 + longScalePixels)
        headingTape.drawLine(fromPoint: startPoint, toPoint: endPoint, width: 1 )
        
    } else if (i % unitPerShortScale) == 0 {
        
        let scalePositionX = CGFloat(i * unitPerShortScale) * pixelPerUnit
        let startPoint = CGPoint(x: scalePositionX, y: labelHeight + 1 + longShortDif)
        let endPoint = CGPoint(x: scalePositionX, y: labelHeight + 1 + longShortDif + shortScalePixels)
        headingTape.drawLine(fromPoint: startPoint, toPoint: endPoint, width: 1)
    }
    
    // Draw degree label and cardinal label
    if (i % unitPerCardinal) == 0 {
        let n = i / unitPerCardinal
        let positionX = CGFloat(n * unitPerCardinal) * pixelPerUnit
        let label = CATextLayer()
        label.font = "Tahoma" as CFTypeRef
        label.fontSize = 12 * pixlesTimes
        label.contentsScale = UIScreen.main.scale
        label.frame = CGRect(x: positionX - 10 * pixlesTimes, y: 1 * pixlesTimes, width: 20 * pixlesTimes, height: labelHeight)
        switch n % 4{
        case 0:
            if isFacingNorth == true {
                label.string = "S"
            } else {
                label.string = "N"
            }
        case 1:
            if isFacingNorth == true {
                label.string = "W"
            } else {
                label.string = "E"
            }
        case 2:
            if isFacingNorth == true {
                label.string = "N"
            } else {
                label.string = "S"
            }
        case 3:
            if isFacingNorth == true {
                label.string = "E"
            } else {
                label.string = "W"
            }
        default:
            label.string = ""
        }
        label.alignmentMode = kCAAlignmentCenter
        label.foregroundColor = scaleColor
        headingTape.addSublayer(label)
        
    } else if (i % unitPerLabel) == 0 {
        
        let n = i / unitPerLongScale
        let positionX = CGFloat(n * unitPerLongScale) * pixelPerUnit
        //                let positionY = labelHeight / 2
        let label = CATextLayer()
        label.font = "Tahoma" as CFTypeRef
        label.fontSize = 12 * pixlesTimes
        label.contentsScale = UIScreen.main.scale
        label.frame = CGRect(x: positionX - 10 * pixlesTimes, y: 1 * pixlesTimes, width: 20 * pixlesTimes, height: labelHeight)
        if isFacingNorth == true {
            var scaleNumber: Int
            if i < 180 {
                scaleNumber = 180 + i
            } else {
                scaleNumber = i - 180
            }
            label.string = String(scaleNumber)
        } else {
            label.string = String(i)
        }
        label.alignmentMode = kCAAlignmentCenter
        label.foregroundColor =  scaleColor
        headingTape.addSublayer(label)
    }
}




///Assemble view by layers
view.layer.addSublayer(headingTape)

//Export view to png file
//UIGraphicsBeginImageContextWithOptions(view.layer.frame.size, false, 0.0)
//view.layer.render(in: UIGraphicsGetCurrentContext()!)
//let viewImage = UIGraphicsGetImageFromCurrentImageContext()!
//UIGraphicsEndImageContext()
//let data = UIImagePNGRepresentation(viewImage)
//let documentsDir = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
//print("documentsDir : \(documentsDir)")
//let writePath = documentsDir.appendingPathComponent("myimage.png")!
//let writeError = try! data?.write(to: writePath)
//print("error: \(writeError)")
//    
//print(writePath.description)

//view.backgroundColor = UIColor.yellow
PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true


//Animation - Transaction

headingTape.frame = CGRect(x: 0.0 * pixelPerUnit, y: 0.0, width: pixelPerUnit * 360.0  * pixlesTimes, height: 31 * pixlesTimes)

print("Heading Tape position: \(headingTape.position.debugDescription)")
print("Heading Tape frame: \(headingTape.frame.debugDescription)")
CATransaction.begin()
CATransaction.setAnimationDuration(0)
CATransaction.setDisableActions(true)
CATransaction.setCompletionBlock({
    print("Transaction completed")
    print("Heading Tape position: \(headingTape.position.debugDescription)")
    print("Heading Tape frame: \(headingTape.frame.debugDescription)")
})
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = headingTape.position
animation.toValue = CGPoint(x: -90.0 * pixelPerUnit, y : headingTape.position.y)
headingTape.add(animation, forKey: "position")
//headingTape.animation
CATransaction.commit()






