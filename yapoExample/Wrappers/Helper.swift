//
//  Helper.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import JGProgressHUD

class Helper {
    static func showIndicator(view: UIView, message: String) -> JGProgressHUD{
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = message;
        hud.show(in: view)        
        return hud
    }
}
