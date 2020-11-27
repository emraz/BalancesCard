//
//  EndPointType.swift
//  Pets
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

protocol EndPointType {

    var baseURL: URL { get }

    var path: String { get }

}
