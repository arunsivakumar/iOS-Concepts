import Foundation

class SecretDetailsPresenter {
    var spy: Spy
    var password: String { return spy.password }
    
    init(with spy: Spy) {
        self.spy = spy
    }
}
