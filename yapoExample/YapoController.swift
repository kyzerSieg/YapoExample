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
import JGProgressHUD;

class YapoController: UIViewController {
    public var hud: JGProgressHUD!;
    public var itunesList: [ItemsItunes] = [];
    public var itunesListLiked: [ItemsItunes] = [];
    var isSearching = false
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
        let likeIcon = LOTAnimatedSwitch(named: NSLocalizedString("lottieSwitch", comment: ""));
        likeIcon.addTarget(self, action: #selector(switchLiked), for: UIControl.Event.valueChanged);
        likeIcon.frame = CGRect(x: 1, y: 1, width: 50, height: 50)
        likeIcon.contentMode = UIView.ContentMode.scaleAspectFit;
        likeIcon.setProgressRangeForOnState(fromProgress: 0.5, toProgress: 1);
        likeIcon.setProgressRangeForOffState(fromProgress: 0, toProgress: 0.5);        
        likeIcon.tag = indexPathCell;
        return likeIcon;
    }
    
    func verifiedHudState(){
        if(self.hud != nil){
            self.hud.dismiss();
        }
    }
    func getArtistName(searchText: String) -> String{
        return searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil);
    }
    
    func getURLSearch(searchText: String) -> String{
        return String(format: NSLocalizedString("iTunesURL", comment: ""),getArtistName(searchText: searchText));
    }
    
    func getItunesArtist(searchText: String){
        let url = self.getURLSearch(searchText: searchText);
        self.verifiedHudState();
        self.hud = Helper.showIndicator(view: self.view, message: NSLocalizedString("activityIndicatorMessage", comment: ""));
        WSHelper.wsRequestWithCallback(url: url, _self: self as! NetworkingRequest, method: .post, parameters: nil, completion: { response in
            guard let resultItunes = ItunesResult.deserialize(from: response.result.value as? NSDictionary) else {
                self.isSearching = false
                self.view.endEditing(true)
                self.view.makeToast(NSLocalizedString("itunesNotFind", comment: ""));
                self.verifiedHudState();
                return;
            }
            self.itunesList = resultItunes.results!;
            self.isSearching = true            
            self.verifiedHudState();
        });
    }
    @objc func switchLiked(animatedSwitch: LOTAnimatedSwitch){}
}
