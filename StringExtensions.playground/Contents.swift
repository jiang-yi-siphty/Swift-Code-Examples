//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension String {
    func isEmail() -> Bool {
        let emailString: String? = self
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
}

str.isEmail()

var emailString = "a.b@g.co"

emailString.isEmail()
