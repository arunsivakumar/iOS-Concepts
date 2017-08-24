import Foundation

class SecretDetailsPresenter {
    var spy: SpyDTO
    var password: String { return spy.password }
    
    init(with spy: SpyDTO) {
        self.spy = spy
    }
}
