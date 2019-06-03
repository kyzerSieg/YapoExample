//
//  WSError.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import HandyJSON;

class WSError: HandyJSON{
    var message : String?;
    var err     : String?;
    
    required init() {}
}
