//
//  Navigator.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 17.10.2024.
//

import Foundation
import UIKit

class AppNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToTableScreen() {
        let viewController = TableViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
