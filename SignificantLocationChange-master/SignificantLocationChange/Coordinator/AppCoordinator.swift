//
//  AppCoordinator.swift
//  SignificantLocationChange
//
//  Created by Doğukan Tizer on 15/6/19.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mapCoordinator = MapCoordinator(window: window)
        mapCoordinator.start()
        
    }
}
