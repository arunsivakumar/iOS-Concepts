import UIKit

var str = "Hello, playground"

struct Employee {
    var name: String
    var id: Int
    var favoriteToy: Toy?
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        case name
        case gift
    }
}

struct EmployeeData {
    var name: String
    var id: Int
    var favoriteToy: Toy
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeId"
        case name
        case gift
    }
}

extension Employee: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(favoriteToy?.name, forKey: .gift)
    }
}

extension EmployeeData: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
         let gift = try values.decode(String.self, forKey: .gift)
         favoriteToy = Toy(name: gift)
    }
}



struct Toy: Codable {
    var name: String
}

let toy1 = Toy(name: "Teddy Bear");
let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
let employee2 = Employee(name: "Apple Appleseed", id: 8, favoriteToy: nil)

let employees = [employee1,employee2]
let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employees)

print(jsonData.description)

let jsonString = String(data: jsonData, encoding: .utf8)
print("encoded:")
//print(jsonString)
// {"name":"John Appleseed","id":7,"favoriteToy":{"name":"Teddy Bear"}}

let jsonDecoder = JSONDecoder()
do{
    let employees = try jsonDecoder.decode([EmployeeData].self, from: jsonData)
    print("JSON decoded:")
    print(employees)
} catch let error {
    print("error decoding")
    print(error.localizedDescription)
}

print("out")

//struct MyStruct: Codable {
//    var name: String
//}
//extension MyStruct: Codable {} // preserves memberwise initializer
//
//MyStruct(name: "Tim")
//
