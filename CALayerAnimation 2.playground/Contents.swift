//: A UIKit based Playground to present user interface
  
import UIKit
import PlaygroundSupport

class myViewController : UIViewController {
    
    let masterLayer = CALayer()
    var altitudeStick = CAShapeLayer()
    var altitudeScale = CALayer()
    
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
        masterLayer.frame = CGRect(x: 10, y: 130, width: 300, height: 500)
        view.layer.addSublayer(masterLayer)
        drawSideslipCursor()
        
        
        
        
        let shiftValue: CGFloat = 2
        performWithAnimation({
            let animation =  CABasicAnimation(keyPath: "position")
            animation.fromValue = self.altitudeStick.position
            print("altitudeStick.position from: \(self.altitudeStick.position)")
            let sideslipVelocityValueToPixel = CGFloat(shiftValue) * (self.altitudeScale.frame.height / 30.0)
            animation.toValue = CGPoint(x: self.altitudeScale.frame.width / 2,
                                        y: sideslipVelocityValueToPixel ) //self.masterLayer.position.y)
            self.altitudeStick.position = animation.toValue as! CGPoint
            self.altitudeStick.add(animation, forKey:  "position")
        }, completionHandler: {
            
            
        })
        
    }
    
    
    func drawSideslipCursor() {
        
        altitudeScale.frame = CGRect(x: masterLayer.frame.width * 2/3 ,
                                     y: 0,
                                     width: masterLayer.frame.width * 1/3,
                                     height: masterLayer.frame.height)
        altitudeScale.borderColor = UIColor.blue.cgColor
        altitudeScale.borderWidth = 3
        
        
        masterLayer.addSublayer(altitudeScale)
        
        altitudeStick.frame = CGRect(x: altitudeScale.frame.width * 3/8,
                                     y: altitudeScale.frame.height,
                                     width: altitudeScale.frame.width * 2/8,
                                     height: altitudeScale.frame.height)
        altitudeStick.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        altitudeStick.borderColor = UIColor.green.cgColor
        altitudeStick.backgroundColor = UIColor.green.cgColor
        altitudeStick.borderWidth = 1
        altitudeScale.addSublayer(altitudeStick)
    }
    
    func performWithAnimation(_ actionsWithAnimation: () -> Void,
                              completionHandler handler: @escaping() -> Void){
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setDisableActions(false)
        CATransaction.setCompletionBlock({
            handler()
        })
        actionsWithAnimation()
        CATransaction.commit()
    }
   
}

PlaygroundPage.current.liveView = myViewController()
