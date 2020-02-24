//
//  Coordinator.swift
//  Coordinator
//
//  Created by Arun Sivakumar on 5/1/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
