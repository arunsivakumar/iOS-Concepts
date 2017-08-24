import UIKit

let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as? [String]


let file = "sample.json" // My change to your code - yours is presumably set off-screen
if let directories = dirs {
    let dir = directories[0]; //documents directory
    let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
    
    //read
    
    let content = try String(contentsOf: path!)
    // works...
    print(content)
    
    struct Safe<Base: Decodable>: Decodable {
        public let value: Base?
        
        public init(from decoder: Decoder) throws {
            do {
                let container = try decoder.singleValueContainer()
                self.value = try container.decode(Base.self)
            } catch {
                //assertionFailure("ERROR---: \(error)\n")
                // TODO: automatically send a report about a corrupted data
                self.value = nil
            }
        }
    }
    
    func parseJSON(_ json: String) {
        do {
            
            let decoder = JSONDecoder()            
            decoder.keyDecodingStrategy = Post.keyDecodingStrategy
            let posts = try decoder.decode([Post].self, from: json.data(using: .utf8)!)
            print(posts)
//            print(posts[0].value!.title)    // prints "Codable: Tips and Tricks"
//            print(posts[1].value)
//            let values = posts.filter{$0.value != nil}
//            print(values)
            // prints "nil"
        } catch {
            print(error)
        }
    }
    
    parseJSON(content)
    
    
    struct Post: Decodable {
        let id: String // More about this type later.
        let title: String
        let subtitle: String?
        let baseCurrency: BaseCurrencyDTO
        
        static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { return .convertFromSnakeCase }

    }
    
    struct BaseCurrencyDTO: Decodable {
        let type: String
    }
}

protocol CustomDecodable: Decodable {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension Decodable {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { return .useDefaultKeys }
}


//
//public struct Id<Entity>: Hashable {
//    public let raw: String
//    public init(_ raw: String) {
//        self.raw = raw
//    }
//
//    public var hashValue: Int {
//        return raw.hashValue
//    }
//
//    public static func ==(lhs: Id, rhs: Id) -> Bool {
//        return lhs.raw == rhs.raw
//    }
//}
