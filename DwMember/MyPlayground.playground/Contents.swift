//: Playground - noun: a place where people can play

import UIKit

var signStr = ""
var data :[String: Any] = ["abc": "bbb","jack":"aaaa","bbc":123]
for key in data.keys.sorted(by: <) {
 let value = data[key]
    print("\(key)=\(value)")
    
}

var data2 = data.sorted(by: <)
signStr = data2.map{ "\($0)=\($1)" }.joined(separator: "&")

print(signStr)



