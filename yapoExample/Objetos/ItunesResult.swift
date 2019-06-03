//
//  ItunesResult.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import HandyJSON;

class ItunesResult: HandyJSON {
    var resultCount : Int?
    var results : [ItemsItunes]?;
    
    required init() {}
}
