//: Playground - noun: a place where people can play

import UIKit


enum peopleType: String {
    case man, woman, homosex,transform
}
print("\(peopleType.homosex.rawValue)")
print("\(peopleType.man.rawValue)")
print("\(peopleType.man)")
print("")


enum emojiString: String {
    case 🍔, 🍤, 🦐,👒
}
print("\(emojiString.🍔.rawValue)")
print("\(emojiString.🍤.rawValue)")
print("\(emojiString.🍤)")
print("")

enum countString: Int {
    case a = 100, b, c, d, e
}
print("\(countString.a)")
print("\(countString.b)")
print("\(countString.c)")
print("\(countString.e)")
print("\(countString.a.rawValue)")
print("\(countString.b.rawValue)")
print("\(countString.c.rawValue)")
print("\(countString.e.rawValue)")
