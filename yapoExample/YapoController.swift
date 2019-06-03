//
//  YapoController.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class YapoController: UIViewController {    
    func loadImageForCell(url: String, cell: ItemsItunesTableViewCell) {
        if let url = URL(string: url) {
            DispatchQueue.global().async { () in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imgArtworkUrl.image = image;
                        }
                    }
                }
            }
        }
    }
   
    func getLottieHeart(positionOnFrame: CGPoint, indexPathCell: Int) -> LOTAnimatedSwitch {
        let likeIcon = LOTAnimatedSwitch(named: "TwitterHeart");
        likeIcon.addTarget(self, action: #selector(switchLiked), for: UIControl.Event.valueChanged);
        likeIcon.frame = CGRect(x: 1, y: 1, width: 50, height: 50)
        likeIcon.contentMode = UIView.ContentMode.scaleAspectFit;
        likeIcon.setProgressRangeForOnState(fromProgress: 0.5, toProgress: 1);
        likeIcon.setProgressRangeForOffState(fromProgress: 0, toProgress: 0.5);        
        likeIcon.tag = indexPathCell;
        return likeIcon;
    }
    
    @objc func switchLiked(animatedSwitch: LOTAnimatedSwitch){}
}
