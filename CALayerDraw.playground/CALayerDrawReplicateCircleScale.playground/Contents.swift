import UIKit

import PlaygroundSupport
import XCPlayground

let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 450))
view.backgroundColor = UIColor.black

var degreesPerLongScale: CGFloat = 10.0
var degreesPerShortScale: CGFloat = 5.0
var pixelsForLongScale: CGFloat = 20
var pixelsForShoreScale: CGFloat = 15
var rangeForDegrees: ClosedRange = -20 ... 20
var rangeForAccuracyDegrees: ClosedRange = -5 ... 5

//Layers
let replicateLongScales = CAReplicatorLayer()
let instanceLayer = CALayer()

func setup(){
    replicateLongScales.frame = view.bounds
    replicateLongScales.instanceCount = 7
    replicateLongScales.instanceColor = UIColor.green.cgColor
    let tenDegreeAngle = CGFloat(Double.pi * 2.0 / 36) /// Float(rangeForDegrees.count)
    replicateLongScales.instanceTransform = CATransform3DMakeRotation(tenDegreeAngle, 0.0, 0.0, 1.0)
    
    let midX = view.bounds.midX - 1 / 2.0
    instanceLayer.frame = CGRect(x: midX, y: 0, width: 1, height: pixelsForLongScale)
    instanceLayer.backgroundColor = UIColor.white.cgColor
    replicateLongScales.addSublayer(instanceLayer)
    view.layer.addSublayer(replicateLongScales)
}

extension CALayer {
    func drawCircleScale(number count: Int, angle degree: CGFloat, length lenth: CGFloat, color: CGColor) {
        let replicateScales = CAReplicatorLayer()
        replicateScales.frame = view.bounds
        replicateScales.instanceCount = count
        replicateScales.instanceColor = UIColor.green.cgColor
        let degreeAngle = CGFloat(Double.pi * 2.0) * (degree/360.0)
        replicateScales.instanceTransform = CATransform3DMakeRotation(degreeAngle, 0.0, 0.0, 1.0)
        
        let midX = bounds.midX - 1 / 2.0
        let instanceLayer = CALayer()
        instanceLayer.frame = CGRect(x: midX, y: 0, width: 1, height: lenth)
        instanceLayer.backgroundColor = UIColor.white.cgColor
        replicateScales.addSublayer(instanceLayer)
        let spanAngle = CGFloat(count - 1) * (degree/360.0) * CGFloat(Double.pi * 2.0) * -1/2
        replicateScales.transform = CATransform3DMakeRotation(spanAngle , 0, 0, 1.0)
        addSublayer(replicateScales)
    }
    
}


//setup()
view.layer.drawCircleScale(number: 9,
                           angle: 10.0,
                           length: pixelsForLongScale,
                           color: UIColor.green.cgColor)
view.layer.drawCircleScale(number: 13,
                           angle: 5.0,
                           length: pixelsForShoreScale,
                           color: UIColor.green.cgColor)
PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
