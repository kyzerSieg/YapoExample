//
//  LikedItemsViewController.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import UIKit


class LikedItemsViewController: UIViewController {
    var itunesListLiked: [ItemsItunes] = [];
    @IBOutlet weak var lblTrack: UILabel!;
    @IBOutlet weak var lblCountry: UILabel!;
    @IBOutlet weak var artistName: UILabel!;
    @IBOutlet weak var imgArtworkUrl: UIImageView!;
    @IBOutlet weak var track: UILabel!;
    @IBOutlet weak var country: UILabel!;    
    @IBOutlet weak var btnClose: UIButton!;
    @IBOutlet weak var itemsPageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsPageControl.numberOfPages = itunesListLiked.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if itunesListLiked.count > 0 {
            setItemPage(numberPage: 0);
            btnClose.isHidden = false;
        }else{
            setItemNotFound();
        }
    }
        
    @IBAction func cerrar(_ sender: Any?){
        self.performSegue(withIdentifier: "prepareForUnwind", sender: self);
    }
    
    @IBAction func changePage(_ sender: UIPageControl) {
        if sender.numberOfPages>0 {
            setItemPage(numberPage: sender.currentPage);
        }
    }
    
    func setItemNotFound(){
        let alertNotFound = UIAlertController(title: NSLocalizedString("appName", comment: ""), message: NSLocalizedString("likedNotFound", comment: ""), preferredStyle: .alert)
        
        let actOk = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "prepareForUnwind", sender: self);
        }
        alertNotFound.addAction(actOk)
        self.present(alertNotFound, animated: true, completion: nil)
    }
    
    func setItemPage(numberPage: Int){
        lblTrack.text = NSLocalizedString("lblTrack", comment: "");
        lblCountry.text = NSLocalizedString("lblCountry", comment: "");
        artistName.text = itunesListLiked[numberPage].artistName;
        track.text = itunesListLiked[numberPage].trackName;
        country.text = itunesListLiked[numberPage].country;
        if let url = URL(string: itunesListLiked[numberPage].artworkUrl100!) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "prepareForUnwind") {
            let _: ViewController = segue.destination as! ViewController;
        }
    }
}
