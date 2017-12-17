//
//  Music.swift
//  MusicPlayer2
//
//  Created by 김진선 on 2017. 12. 16..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

struct Music {
    let title: String
    let artist: String
    let albumImage: UIImage
    
    
}

var musicList = [Music(title: "3am", artist: "HONNE", albumImage: #imageLiteral(resourceName: "3am")),
                 Music(title: "Calling Me", artist: "Aquilo", albumImage: #imageLiteral(resourceName: "Calling Me")),
                 Music(title: "Make you love me (Feat. Zak Abel)", artist: "Jarreau Vandal", albumImage: #imageLiteral(resourceName: "Mak you love me")),
                 Music(title: "Native Son Prequel(Feat. Leo Napier)", artist: "Gramatik", albumImage: #imageLiteral(resourceName: "Native Son Prequel")),
                 Music(title: "San Francisco Street", artist: "Sun Rai", albumImage: #imageLiteral(resourceName: "San Francisco Street")),
                 Music(title: "Who I Am (Feat. LunchMoney Lewis)", artist: "Maroon 5", albumImage: #imageLiteral(resourceName: "Who I Am"))]

