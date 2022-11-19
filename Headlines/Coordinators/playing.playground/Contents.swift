import UIKit



func solution(digit: String, num: String) -> Int {
    var dic = [Int:String]()
    
    for (index, val) in digit.enumerated() {
        dic[index + 1] = "\(val)"
    }
    var count = 0
    
    for nums in num {
        let item = dic.filter {$0.value == "\(nums)"}.keys.first!
        let zeroItem = dic.filter {$0.value == "0"}.keys.first!
        
        if zeroItem == item {
            count += 1
        }
        
        count += abs(Int(item) - zeroItem )
    }
    
    return count
}


//let sol = solution(digit: "9876543210", num: "210")
//
//var airports = ["NGR" : "Nigeria"]
//
//if let oldValue = airports.updateValue("Naira", forKey: "NGR") {
//    //print(oldValue)
//}
//
//if let oldValue = airports.removeValue(forKey: "NGR") {
//    print(oldValue)
//}

//let str = "1000000001 1000000002 1000000003 1000000004 1000000005"
//let items = str.components(separatedBy: " ").map { Int($0) ?? 0 }.reduce(0,+)
//print(items)

let data: Data

let json = try? JSONSerialization.jsonObject(with: data, options: [])
