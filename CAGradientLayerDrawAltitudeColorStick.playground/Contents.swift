//: A UIKit based Playground to present user interface
import UIKit
import PlaygroundSupport

class myViewController : UIViewController {
    
    let selectedColorView = UIView()
    
    override func loadView() {
        let view = UIView()

        let label = UILabel()
        label.text = "Hello World!"
        label.textColor = .white
        
        view.addSubview(label)
        self.view = view
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 1200)
        view.backgroundColor = UIColor.gray
        drawAltitudeColorStick()
        
        
        selectedColorView.frame = CGRect(x: 100, y: 45, width: 45, height: 45)
        view.addSubview(selectedColorView)
    }
    
    func drawAltitudeColorStick() {
        let altitudeStickLayer = CALayer()
        altitudeStickLayer.frame = CGRect(x: 45, y: 10, width: 40, height: view.frame.height - 20)
        
        let colorStickLayer = CAGradientLayer()
        colorStickLayer.frame = CGRect(x: 0, y: 0, width: 8, height: altitudeStickLayer.bounds.height)
        colorStickLayer.colors = [UIColor(red: 1, green: 0, blue: 1, alpha: 0.6).cgColor as AnyObject,
                                  UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor as AnyObject,
                                  UIColor(red: 0, green: 1, blue: 1, alpha: 1).cgColor as AnyObject,
                                  UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor as AnyObject,
                                  UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor as AnyObject,
                                  UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor as AnyObject]
        colorStickLayer.locations = [0, 0.21, 0.67, 0.79, 0.91, 1] as [NSNumber]?
        colorStickLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        colorStickLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        altitudeStickLayer.addSublayer(colorStickLayer)
        
        drawAltitudeScale(by: [0, 400, 2000, 5000, 10000, 20000, 40000], on: altitudeStickLayer)
        view.layer.addSublayer(altitudeStickLayer)
        
        let selectedColor = getColorfromPixel(CGPoint(x: 4, y: 150), from: colorStickLayer)
        selectedColorView.backgroundColor = selectedColor
    }
    
    
    func drawAltitudeScale(by altitudeArray: [Int], on layer: CALayer){
        var newAltitudeArray = [CGFloat]()
        for altitude in altitudeArray {
            newAltitudeArray.append(CGFloat(altitude))
        }
        drawAltitudeScale(by: newAltitudeArray, on: layer)
    }
    
    func drawAltitudeScale(by altitudeArray: [Float], on layer: CALayer){
        var newAltitudeArray = [CGFloat]()
        for altitude in altitudeArray {
            newAltitudeArray.append(CGFloat(altitude))
        }
        drawAltitudeScale(by: newAltitudeArray, on: layer)
    }
    func drawAltitudeScale(by altitudeArray: [Double], on layer: CALayer){
        var newAltitudeArray = [CGFloat]()
        for altitude in altitudeArray {
            newAltitudeArray.append(CGFloat(altitude))
        }
        drawAltitudeScale(by: newAltitudeArray, on: layer)
    }
    func drawAltitudeScale(by altitudeArray: [CGFloat], on layer: CALayer){
        for altitude in altitudeArray {
            let scaleY = getLayerHeight(by: altitude, on: layer)
            drawLine(fromPoint: CGPoint(x: 0, y: scaleY),
                           toPoint: CGPoint(x: 10, y: scaleY ),
                           width: 1, on: layer)
            let altitudeLabel: CATextLayer = CATextLayer()
            altitudeLabel.frame = CGRect(x: 8, y: scaleY, width: 30, height: 15)
            altitudeLabel.string = String("\(altitude) ")
            altitudeLabel.fontSize = 12
            altitudeLabel.contentsScale = UIScreen.main.scale
            altitudeLabel.borderColor = UIColor.red.cgColor
            altitudeLabel.borderWidth = 1
            altitudeLabel.alignmentMode = kCAAlignmentCenter
            altitudeLabel.foregroundColor = UIColor.blue.cgColor
            layer.addSublayer(altitudeLabel)
        }
    }
    
    func getLayerHeight(by altitude: CGFloat, on layer: CALayer) -> CGFloat{
        let maxiumAltitude: CGFloat = 40000.0
         let scaleY = CGFloat(1 - sqrt(100 * altitude / maxiumAltitude) / 10) * layer.frame.height
        return scaleY
    }
    
    
    func getColorfromPixel(_ pixelPoint:CGPoint, from layer: CALayer) -> UIColor{
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -pixelPoint.x, y: -pixelPoint.y)
        
        layer.render(in: context!)
        
        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
        
        return color
    }
    
    
    
    func drawLine(fromPoint start: CGPoint, toPoint end:CGPoint, width: Int, on layer: CALayer){
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.lineWidth = CGFloat(width)
        line.strokeColor = UIColor.black.cgColor
        layer.addSublayer(line)
    }
}

PlaygroundPage.current.liveView = myViewController()


