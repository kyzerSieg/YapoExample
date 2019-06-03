//
//  ViewController.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//
import Foundation
import UIKit
import Alamofire;
import JGProgressHUD;
import Toast_Swift;
import Lottie

class ViewController: YapoController, NetworkingRequest, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    private var hud: JGProgressHUD!;
    @IBOutlet var sbSearch: UISearchBar!;
    var itunesList: [ItemsItunes] = [];
    var itunesListLiked: [ItemsItunes] = [];
    let cellReuseIdentifier = "Cell";
    var isSearching = false
    @IBOutlet lazy var mainTable: UITableView! = {
        let tvItems = UITableView()
        tvItems.register(ItemsItunesTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        return tvItems
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTable.delegate = self;
        self.mainTable.dataSource = self;
        self.sbSearch.delegate = self
        self.sbSearch.returnKeyType = UIReturnKeyType.done
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = self.getURLSearch();
        self.verifiedHudState();
        self.hud = Helper.showIndicator(view: self.view, message: NSLocalizedString("activityIndicatorMessage", comment: ""));
        WSHelper.wsRequestWithCallback(url: url, _self: self, method: .post, parameters: nil, completion: { response in
            guard let resultItunes = ItunesResult.deserialize(from: response.result.value as? NSDictionary) else {
                self.isSearching = false
                self.view.endEditing(true)
                self.view.makeToast(NSLocalizedString("itunesNotFind", comment: ""));
                self.verifiedHudState();
                return;
            }
            self.itunesList = resultItunes.results!;
            self.isSearching = true
            self.mainTable.reloadData();
            self.verifiedHudState();
        });
    }
    
    func verifiedHudState(){
        if(self.hud != nil){
            self.hud.dismiss();
        }
    }
    func getArtistName() -> String{
        return sbSearch.text!.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil);
    }
    
    func getURLSearch() -> String{
        return String(format: NSLocalizedString("iTunesURL", comment: ""),getArtistName());
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itunesList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ItemsItunesTableViewCell
        if isSearching {
            if(self.itunesList.count > 0){
                let item = self.itunesList[indexPath.row];                
                cell.data = item;
                (cell.accessoryView as! UISwitch).isOn = (itunesListLiked.filter { $0 === itunesList[indexPath.row] }).count > 0 ? true : false;
                cell.accessoryView?.tag = indexPath.row
                (cell.accessoryView as! UISwitch).addTarget(self, action: #selector(switchLiked), for: .valueChanged);
            }
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92;
    }
    
    @objc override func switchLiked(animatedSwitch: LOTAnimatedSwitch){
        if(animatedSwitch.isOn){
            itunesListLiked.append(itunesList[animatedSwitch.tag]);
        }else{
            itunesListLiked = itunesListLiked.filter {$0 !== itunesList[animatedSwitch.tag]}
        }
    }
    
    @IBAction func buttonClick(_ sender: UIButton){
         self.performSegue(withIdentifier: "likedSegue", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "likedSegue") {
            let controller: LikedItemsViewController = segue.destination as! LikedItemsViewController;
            controller.itunesListLiked = itunesListLiked;
        }
    }
    
    @IBAction func prepareForUnwind(_ segue:UIStoryboardSegue) { }
}

