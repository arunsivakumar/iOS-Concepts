import Foundation

typealias BlockWithSource = (Source)->Void

protocol SpyListPresenter {
    var data: [SpyDTO] { get }
    func loadData(finished: @escaping BlockWithSource)
}

class SpyListPresenterImpl: SpyListPresenter {
    var data = [SpyDTO]()
    
    fileprivate var modelLayer: ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
}

//MARK: - Data Methods
extension SpyListPresenterImpl {
    func loadData(finished: @escaping BlockWithSource) {
        modelLayer.loadData { [weak self] source, spies in
            self?.data = spies
            finished(source)
        }
    }
}

