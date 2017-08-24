import Foundation

class DetailPresenter {
    var spy: Spy!
    
    var imageName: String { return spy.imageName }
    var name: String { return spy.name }
    var age: String { return String(spy.age) }
    var gender: String { return spy.gender }
    
    init(with spy: Spy) {
        self.spy = spy
    }
    
}
