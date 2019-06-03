//
//  ItemsItunesTableViewCell.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import UIKit

class ItemsItunesTableViewCell: UITableViewCell{
    @IBOutlet weak var lblArtistName: UILabel!;
    @IBOutlet weak var lblCollectionName: UILabel!;
    @IBOutlet weak var lblPreviewUrl: UILabel!;
    @IBOutlet weak var imgArtworkUrl: UIImageView!;
    
    var data:ItemsItunes?{
        didSet{
            updateValues()
        }
    }
    
    private func updateValues(){
        guard data != nil else{
            return
        }
        lblArtistName.text = data!.artistName;
        lblCollectionName.text = data!.trackName;
        lblPreviewUrl.text = data!.previewUrl;
        let swLiked = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))        
        self.accessoryView = swLiked;
        if let url = URL(string: (data?.artworkUrl100)!) {
            DispatchQueue.global().async { () in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imgArtworkUrl.image = image;
                        }
                    }
                }
            }
        }
    }
}
