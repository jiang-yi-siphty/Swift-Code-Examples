//: Playground - noun: a place where people can play

import UIKit

let dic = ["2": "B", "1": "A", "3": "C"]

do {
    let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
    // here "jsonData" is the dictionary encoded in JSON data
    
    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
    // here "decoded" is of type `Any`, decoded from JSON data
    
    // you can now cast it with the right type
    if let dictFromJSON = decoded as? [String:String] {
        // use dictFromJSON
    }
} catch {
    print(error.localizedDescription)
}


let queue = DispatchQueue(label: "abcd", attributes: .concurrent)
let queue2 = DispatchQueue(label: "ab")

DispatchQueue.global().sync {
    (0 ... 10).map{_ in
        print("🍔")
    }
}

queue.async {
    for _ in 0 ... 10 {
        print("🔑")
    }
}

queue.async {
    for _ in 0 ... 10 {
        print("👨🏻‍💻")
    }
}

let times = 0 ... 10
times.map({_ in
    print("🙊")
})


