import UIKit

import PlaygroundSupport
import XCPlayground




extension CALayer {
    //Draw Section
    func drawLine(fromPoint start: CGPoint, toPoint end:CGPoint, width: Int, isDash: Bool){
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.lineWidth = CGFloat(width)
        line.strokeColor = UIColor.green.cgColor
        if isDash {
            line.lineDashPattern = [4, 4]
        }
        addSublayer(line)
    }
}

extension CGFloat{
    
    func half() -> CGFloat{
        return self / 2
    }
    
    
    func middle() -> CGFloat{
        return self / 2
    }
}



let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 950))
view.backgroundColor = UIColor.black

//var pixelsPerDegree: CGFloat = 10.48
var pixelsPerDegree: CGFloat = 4
var degreesPerScale: Int = 10
var scaleWidth: CGFloat = 100
var gapWidth: CGFloat = 20
var bracketHeight: CGFloat = 10
var sPoint: CGPoint
var ePoint: CGPoint
var count: Int

//Layers
let ladder = CALayer()
ladder.frame = view.bounds
let lFrame = ladder.frame
for var degree in -100 ... +100 {
    print(degree)
    count = degree + 100
    degree = degree * -1
    if count % degreesPerScale == 0 {
        let positionY = CGFloat(count) * pixelsPerDegree
        
        if degree > 0 {
            
            sPoint = CGPoint(x: lFrame.width.half() - gapWidth.half() - scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
            
            sPoint = CGPoint(x: lFrame.width.half() + gapWidth.half() + scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
            
            sPoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY + bracketHeight)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
            
            sPoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY + bracketHeight)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
        }else if degree < 0 {
            
            sPoint = CGPoint(x: lFrame.width.half() - gapWidth.half() - scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: true)
            
            
            sPoint = CGPoint(x: lFrame.width.half() + gapWidth.half() + scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: true)
            
            sPoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY - bracketHeight)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
            
            sPoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY - bracketHeight)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
        } else {
            
            
            sPoint = CGPoint(x: lFrame.width.half() - gapWidth.half() - scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() - gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
            
            
            sPoint = CGPoint(x: lFrame.width.half() + gapWidth.half() + scaleWidth,
                             y: positionY)
            ePoint = CGPoint(x: lFrame.width.half() + gapWidth.half(),
                             y: positionY)
            ladder.drawLine(fromPoint: sPoint, toPoint: ePoint, width: 1, isDash: false)
        }
        
        
    }
    
}

view.layer.addSublayer(ladder)


PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true

