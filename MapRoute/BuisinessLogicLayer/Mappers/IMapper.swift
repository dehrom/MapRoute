//
//  IMapper.swift
//  MapRoute
//
//  Created by Valery Kokanov on 27.11.16.
//  Copyright © 2016 dehrom. All rights reserved.
//

import Foundation

protocol IMapper: class {
    
    associatedtype T
    associatedtype R
    
    func transform(Model model: T?) -> R
    
}
