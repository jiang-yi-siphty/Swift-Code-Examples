import UIKit

import PlaygroundSupport
import XCPlayground

let view = UIView(frame: CGRect(x: 0, y: 0, width: 650, height: 750))
view.backgroundColor = UIColor.lightGray



//Layers
let replicatorLayer = CAReplicatorLayer()
let instanceLayer = CALayer()

let replicatorInstances = 2
replicatorLayer.instanceCount = replicatorInstances
replicatorLayer.borderWidth = 1.3
replicatorLayer.borderColor = UIColor.red.cgColor
replicatorLayer.frame = CGRect(x: 100, y: 100, width: 160, height: 90)

instanceLayer.borderColor = UIColor.yellow.cgColor
instanceLayer.borderWidth = 4
instanceLayer.backgroundColor = UIColor.brown.cgColor
instanceLayer.bounds = CGRect(x: 0, y: 0, width: 160, height: 90)
//view.layer.addSublayer(instanceLayer)

let imageLayer0 = CALayer()
imageLayer0.contents = UIImage(named: "wd.png")?.cgImage
imageLayer0.contentsGravity = kCAGravityResizeAspectFill
//imageLayer.contentsScale = kCAGravityResizeAspectFill
imageLayer0.masksToBounds = true
imageLayer0.frame = CGRect(x: 300, y: 300, width: 200, height: 200)
view.layer.addSublayer(imageLayer0)


let imageLayer = CALayer()
imageLayer.contents = UIImage(named: "wd.png")?.cgImage
imageLayer.contentsGravity = kCAGravityResizeAspectFill
//imageLayer.contentsScale = kCAGravityResizeAspectFill
imageLayer.masksToBounds = true
imageLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
view.layer.addSublayer(imageLayer)

let midLayer = CALayer()
midLayer.bounds = CGRect(x: 0, y: 0, width: replicatorLayer.bounds.width / 2, height: replicatorLayer.bounds.height)
midLayer.addSublayer(imageLayer)
midLayer.masksToBounds = true
imageLayer.position = CGPoint(x: midLayer.frame.width / 2, y: midLayer.frame.height / 2)

replicatorLayer.position
let replicatorViewWidth = replicatorLayer.bounds.width / CGFloat(replicatorInstances)
replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorViewWidth, 0.0, 0.0)

replicatorLayer.masksToBounds = true

replicatorLayer.addSublayer(midLayer)
view.layer.addSublayer(replicatorLayer)

replicatorLayer.position
midLayer.position
midLayer.position = CGPoint(x: replicatorLayer.bounds.width / CGFloat(replicatorInstances * 2), y: replicatorLayer.bounds.height / 2)
midLayer.position
instanceLayer.position
instanceLayer.position = midLayer.position


PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
