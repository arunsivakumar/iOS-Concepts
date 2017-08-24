////
//// Created by Arun Sivakumar on 15/10/19.
//// Copyright © 2019 Arun Sivakumar. All rights reserved.
////
//
import UIKit
//
//class test1 {
//    let test: Int
//    var lest: Int
//
//    init(intOne: Int,int2: Int) {
//        test = intOne
//        lest = int2
//    }
//
//    func update(value: Int) {
//        lest += value
//    }
//}
//
//final class test2 {
//    let test: Int
//    var lest: Int
//
//    init(intOne: Int,int2: Int) {
//        test = intOne
//        lest = int2
//    }
//
//    func update(value: Int) {
//        lest += value
//    }
//}
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let time1 = Date().timeIntervalSince1970
//        print("\ntime1:\(time1)")
//        let  classtest1 = test1.init(intOne: 1, int2: 2)
//        for i in 1...1000000000 {
//            classtest1.update(value: 2)
//        }
//
//        let time2 = Date().timeIntervalSince1970
//        print("\ntime2:\(time2)")
//        let diff1 = time2 - time1
//        print("\nDiff1 Time: \(diff1)")
//
//        print("-----------------------------")
//
//        let time5 = Date().timeIntervalSince1970
//        print("\ntime5:\(time5)")
//        let  classtest1a = test1.init(intOne: 1, int2: 2)
//        for i in 1...1000000000 {
//            classtest1a.update(value: 2)
//        }
//
//        let time6 = Date().timeIntervalSince1970
//        print("\ntime6:\(time6)")
//        let diff3 = time6 - time5
//        print("\nDiff3 Time: \(diff3)")
//
//        print("-----------------------------")
//
//        let time3 = Date().timeIntervalSince1970
//        print("\ntime 3:\(time3)")
//        let  classtest2 = test2.init(intOne: 1, int2: 2)
//        for i in 1...1000000000 {
//            classtest2.update(value: 2)
//        }
//
//        let time4 = Date().timeIntervalSince1970
//        print("\ntime 4:\(time4)")
//        let diff2 = time4 - time3
//        print("\nDiff2 Time: \(diff2)")
//
//        print("\nFinal Diff Time for final: \(diff2 - diff1)")
//
//        print("-----------------------------")
//
//    }
//
//    func getDateDiff(_ start: Date,_ end: Date) -> Int  {
//        let calendar = Calendar.current
//        let dateComponents = calendar.compare(start, to: end, toGranularity: .nanosecond)
//        let seconds = dateComponents.rawValue
//        //print("Seconds: \(seconds)")
//        return seconds
//    }
//}
//

final class Address {
    var street = ""
    var city = ""
    var state = "";
    enum AddressAttributes {
        case Street
        case City
        case State
    }
    func update(value: String, attribute: AddressAttributes){
        switch attribute {
        case .Street:
            street = value;
        case .City:
            city = value;
        case .State:
            state = value;
        }
    }
    func updateAttribute(value: String, attribute: AddressAttributes){
        update(value: value, attribute: attribute)
    }
}

final class Address1 {
    var street = ""
    var city = ""
    var state = "";
    enum AddressAttributes {
        case Street
        case City
        case State
    }
    func update(value: String, attribute: AddressAttributes){
        switch attribute {
        case .Street:
            street = value;
        case .City:
            city = value;
        case .State:
            state = value;
        }
    }
    func updateAttribute(value: String, attribute: AddressAttributes){
        update(value: value, attribute: attribute)
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTime {
            var address = Address()
            
            for _ in 0..<10000000 {
                address.update(value: "Pier 39", attribute: .Street)
                address.update(value: "San Fransciso", attribute: .City)
                address.update(value: "CA", attribute: .State)
            }
        }
        
        calculateTime {
            var address = Address()
            
            for _ in 0..<10000000 {
                address.update(value: "Pier 39", attribute: .Street)
                address.update(value: "San Fransciso", attribute: .City)
                address.update(value: "CA", attribute: .State)
            }
        }
        
        calculateTime {
            var address = Address1()
            
            for _ in 0..<10000000 {
                address.update(value: "Pier 39", attribute: .Street)
                address.update(value: "San Fransciso", attribute: .City)
                address.update(value: "CA", attribute: .State)
            }
        }
    }
    
    func calculateTime(block : (() -> Void)) {
        let start = DispatchTime.now()
        block()
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("\nTime: \(timeInterval) seconds")
    }
}
