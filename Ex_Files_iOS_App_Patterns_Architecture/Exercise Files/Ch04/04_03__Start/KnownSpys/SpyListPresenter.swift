import Foundation

typealias BlockWithSource = (Source)->Void
typealias VoidBlock = ()->Void
typealias SpiesAndSourceBlock = (Source, [Spy])->Void
typealias SpiesBlock = ([Spy])->Void

class SpyListPresenter {
    var data = [Spy]()
    fileprivate var modelLayer = ModelLayer()
}

//MARK: - Data Methods
extension SpyListPresenter {
    
    func loadData(finished: @escaping BlockWithSource) {
        modelLayer.loadData { [weak self] source, spies in
            self?.data = spies
            finished(source)
        }
    }
}




