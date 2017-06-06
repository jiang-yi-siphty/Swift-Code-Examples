import UIKit

import PlaygroundSupport
import XCPlayground

let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
view.backgroundColor = UIColor.red
container.addSubview(view)



////: Playground - noun: a place where people can play
//import UIKit
//
//import XCPlayground
//import PlaygroundSupport
//var str = "Hello, playground"
//let demoView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//demoView.backgroundColor = UIColor.lightGray
//
//
//let layer :CALayer = {
//    let aLayer = CALayer()
//    aLayer.frame = CGRect(x: demoView.frame.origin.x + 20 ,
//                          y: demoView.frame.origin.y + 20 ,
//                          width: demoView.frame.width - 40 ,
//                          height: demoView.frame.height - 40)
//    print(aLayer.bounds)
//    print(aLayer.frame)
//    
//    aLayer.borderColor = UIColor.red.cgColor
//    aLayer.borderWidth = 2
//    return aLayer
//}()
var degreesPerLongScale: CGFloat = 5.0
var degreesPerShortScale: CGFloat = 1.0
var rangeForDegrees: ClosedRange = -20 ... 20
var rangeForAccuracyDegrees: ClosedRange = -5 ... 5

//Layers
let replicateLongScales = CAReplicatorLayer()
let instanceLayer = CALayer()

func setup(){
    replicateLongScales.frame = view.bounds
    replicateLongScales.instanceCount = 40
    replicateLongScales.instanceColor = UIColor.green.cgColor
    let tenDegreeAngle = Float(Double.pi * 2.0 / 36) /// Float(rangeForDegrees.count)
    replicateLongScales.instanceTransform = CATransform3DMakeRotation(CGFloat(tenDegreeAngle * (-1)), 0.0, 0.0, 1.0)
    
    let midX = view.bounds.midX - 1 / 2.0
    instanceLayer.frame = CGRect(x: midX, y: 10, width: 1, height: 5)
    instanceLayer.backgroundColor = UIColor.white.cgColor
    replicateLongScales.addSublayer(instanceLayer)
    view.layer.addSublayer(replicateLongScales)
}


setup()
//demoView.layer.addSublayer(layer)
PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
