//
//  MapCoordiantor.swift
//  SignificantLocationChange
//
//  Created by Doğukan Tizer on 15/6/19.
//

import UIKit

class MapCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var window: UIWindow
    private var mapViewController: MapViewController
    init(window: UIWindow) {
        self.presenter = UINavigationController()
        self.window = window
        self.window.rootViewController = presenter
        self.window.makeKeyAndVisible()
        mapViewController = MapViewController()

    }
    func start() {
        self.presenter.pushViewController(mapViewController, animated: true)
        
    }
}
