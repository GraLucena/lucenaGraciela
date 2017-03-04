//
//  Coordinator.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    var name: String {
        return String(describing: self)
    }
}
