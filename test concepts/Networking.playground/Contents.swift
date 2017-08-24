//: Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


var str = "Hello, playground"


struct Resource<A> {
    let url: NSURL
    let parse: (NSData) -> A?
}

let episodesResource = Resource<NSData>(url: url, parse: { data in
    return data
})


final class Webservice{
    func load<A>(resource:Resource<A>,completion:@escaping (A?)->()){
        URLSession.shared.dataTask(with: resource.url as URL) { (data, _, _) in
             guard let data = data else {
                completion(nil)
                return
            }
            completion(resource.parse(data))
        }.resume()
    }
    
}

Webservice().load(episodesResource) { result in
    print(result)
}