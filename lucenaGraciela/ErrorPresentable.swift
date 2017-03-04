//
//  ErrorPresentable.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation

protocol ErrorPresentable: Error {
    var title: String? { get }
    var message: String? { get }
}
