//
//  Service.swift
//  MusicPlayer2
//
//  Created by 김진선 on 2017. 12. 16..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit
import AVFoundation

class Service {

    static let instance = Service()
    
    var player = AVAudioPlayer()
    let popupView = PopUpView()
    
    func  playSound(title: String, artist: String) {
        
        let soundURL = Bundle.main.url(forResource: "\(title) - \(artist)", withExtension: "m4a")
        
        
        do {                                                                // one of the way swift can handle error
            player = try AVAudioPlayer(contentsOf: soundURL!)
            
        }
            
        catch {
            print(error)
        }
        
        player.play()
        
        
    }

}
