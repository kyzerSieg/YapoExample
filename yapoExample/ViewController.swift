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
import Toast_Swift;
import Lottie

class ViewController: YapoController, NetworkingRequest, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {    
    @IBOutlet var sbSearch: UISearchBar!;
    let cellReuseIdentifier = "Cell";
    
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
    
    @IBAction func searchArtist( sender: UISearchBar){
        super.getItunesArtist(searchText: sbSearch.text!)
        self.mainTable.reloadData();
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.isSearching = false
            view.endEditing(true)
            return;
        }else{
            super.getItunesArtist(searchText: searchText)
            self.mainTable.reloadData();
        }
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
                let point = CGPoint(x: cell.frame.width-50, y: cell.frame.height/2);
                cell.accessoryView = super.getLottieHeart(positionOnFrame: point, indexPathCell: indexPath.row)
                (cell.accessoryView as! LOTAnimatedSwitch).isOn = !((itunesListLiked.filter { $0 === itunesList[indexPath.row] }).count > 0 ? true : false);
            }
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92;
    }
    
    @objc override func switchLiked(animatedSwitch: LOTAnimatedSwitch){
        if(!animatedSwitch.isOn){
            if itunesList.count > animatedSwitch.tag{
                itunesListLiked.append(itunesList[animatedSwitch.tag]);
            }
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

