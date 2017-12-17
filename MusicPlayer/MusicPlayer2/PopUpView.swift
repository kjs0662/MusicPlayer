//
//  PopUpView.swift
//  MusicPlayer2
//
//  Created by 김진선 on 2017. 12. 16..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit
import AVFoundation

class PopUpView: UIView {
    

    
    
    var albumImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "3am"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var playBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        button.tintColor = UIColor.darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.playBtnPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    var nextBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(ViewController.nextBtnPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var previousBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "previous"), for: .normal)
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(ViewController.previousBtnPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var clearBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "clear"), for: .normal)
        button.tintColor = UIColor.darkGray
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor.darkGray
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    @objc func dismiss() {
        
        self.removeFromSuperview()
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(albumImageView)
        albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        albumImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -300).isActive = true
        
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(artistLabel)
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(clearBtn)
        clearBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        clearBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        clearBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        clearBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(playBtn)
        playBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        playBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(nextBtn)
        nextBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        nextBtn.leftAnchor.constraint(equalTo: playBtn.rightAnchor, constant: 30).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(previousBtn)
        previousBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        previousBtn.rightAnchor.constraint(equalTo: playBtn.leftAnchor, constant: -30).isActive = true
        previousBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        previousBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(progressBar)
        progressBar.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 50).isActive = true
        progressBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        progressBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
    }
    
//    convenience init(title:String, artist:String, image: UIImage, frame: CGRect) {
//        self.init(frame: frame)
//        titleLabel.text = title
//        artistLabel.text = artist
//        albumImageView.image = image
//        if isPlaying == true {
//            playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
//            playBtn.tintColor = UIColor.darkGray
//        } else {
//            playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
//            playBtn.tintColor = UIColor.darkGray
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
