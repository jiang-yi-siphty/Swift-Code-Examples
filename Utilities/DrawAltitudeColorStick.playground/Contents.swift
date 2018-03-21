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
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 700)
        view.backgroundColor = UIColor.gray

        
    }

    
}

PlaygroundPage.current.liveView = myViewController()
