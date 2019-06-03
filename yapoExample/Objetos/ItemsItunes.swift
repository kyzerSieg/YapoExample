//
//  ItemsItunes.swift
//  yapoExample
//
//  Created by Mauricio Felipe Pacheco Diaz on 02-06-19.
//  Copyright © 2019 Mauricio Felipe Pacheco Diaz. All rights reserved.
//

import Foundation
import HandyJSON;

class ItemsItunes: HandyJSON {
    
    var wrapperType: String?;
    var kind: String?;
    var artistId: String?;
    var collectionId: String?;
    var trackId: String?;
    var artistName: String?;
    var collectionName: String?;
    var trackName: String?;
    var collectionCensoredName: String?;
    var trackCensoredName: String?;
    var artistViewUrl: String?;
    var collectionViewUrl: String?;
    var trackViewUrl: String?;
    var previewUrl: String?;
    var artworkUrl60: String?;
    var artworkUrl100: String?;
    var collectionPrice: String?;
    var trackPrice: String?;
    var collectionExplicitness: String?;
    var trackExplicitness: String?;
    var discCount: String?;
    var discNumber: String?;
    var trackCount: String?;
    var trackNumber: String?;
    var trackTimeMillis: String?;
    var country: String?;
    var currency: String?;
    var primaryGenreName: String?;
    
    required init() {}
}
