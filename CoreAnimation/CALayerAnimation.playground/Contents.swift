//: A UIKit based Playground to present user interface
  
import UIKit
import PlaygroundSupport

class myViewController : UIViewController {
    
    let masterLayer = CALayer()
    var sideslipCursor = CAShapeLayer()
    
    override func loadView() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 550, height: 150)
        let label = UILabel()
        label.text = "Hello World!"
        label.textColor = .white
        label.backgroundColor = UIColor.red
        view.addSubview(label)
        self.view = view
        masterLayer.backgroundColor = UIColor.white.cgColor
        masterLayer.frame = CGRect(x: 10, y: 130, width: 300, height: 100)
        view.layer.addSublayer(masterLayer)
        drawSideslipCursor()
        
        let shiftValue: CGFloat = 5
        performWithAnimation({
            let animation =  CABasicAnimation(keyPath: "position")
//            animation.fillMode = kCAFillModeBackwards //kCAFillModeRemoved
//            animation.isRemovedOnCompletion = true
            animation.fromValue = self.sideslipCursor.position
            print("self.sideslipCursor.position : \(self.sideslipCursor.position)")
            let sideslipVelocityValueToPixel = CGFloat(shiftValue) * (self.masterLayer.frame.width / 30.0)
            animation.toValue = CGPoint(x: sideslipVelocityValueToPixel,
                                        y: 0 ) //self.masterLayer.position.y)
            self.sideslipCursor.position = animation.toValue as! CGPoint
            self.sideslipCursor.add(animation, forKey:  "position")
        }, completionHandler: {
            self.performWithAnimation({
            let animation =  CABasicAnimation(keyPath: "position")
            //            animation.fillMode = kCAFillModeBackwards //kCAFillModeRemoved
            //            animation.isRemovedOnCompletion = true
            animation.fromValue = self.sideslipCursor.position
            print("self.sideslipCursor.position : \(self.sideslipCursor.position)")
            let sideslipVelocityValueToPixel = CGFloat(shiftValue) * (self.masterLayer.frame.width / 30.0)
            animation.toValue = CGPoint(x: sideslipVelocityValueToPixel * -1,
                                        y: 0 ) //self.masterLayer.position.y)
            self.sideslipCursor.position = animation.toValue as! CGPoint
            self.sideslipCursor.add(animation, forKey:  "position")
                }, completionHandler: {
            })
            
        })
        
    }
    
    
    func drawSideslipCursor() {
        let cursorCenter = CGPoint(x: masterLayer.bounds.size.width / 2, y: masterLayer.bounds.size.height / 2)
        let cursorRadius = masterLayer.bounds.size.height / 2 * 0.7
        let circlePath = UIBezierPath(arcCenter: cursorCenter,
                                      radius: cursorRadius,
                                      startAngle: CGFloat(0),
                                      endAngle:CGFloat(Double.pi * 2),
                                      clockwise: true)
        sideslipCursor.path = circlePath.cgPath
        sideslipCursor.fillColor = UIColor.clear.cgColor
        sideslipCursor.strokeColor = UIColor.green.cgColor
        sideslipCursor.lineWidth = 2.0
        masterLayer.addSublayer(sideslipCursor)
    }
    
    func performWithAnimation(_ actionsWithAnimation: () -> Void,
                              completionHandler handler: @escaping() -> Void){
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        CATransaction.setDisableActions(false)
        CATransaction.setCompletionBlock({
            handler()
        })
        actionsWithAnimation()
        CATransaction.commit()
    }
   
}

PlaygroundPage.current.liveView = myViewController()
