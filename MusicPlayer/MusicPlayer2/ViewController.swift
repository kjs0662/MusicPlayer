//
//  ViewController.swift
//  MusicPlayer2
//
//  Created by 김진선 on 2017. 12. 16..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit
import AVFoundation

var isPlaying:Bool?


class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    
    @IBOutlet weak var playingMusicImageView: UIImageView!
    @IBOutlet weak var playingMusicTitle: UILabel!
    @IBOutlet weak var playingMusicArtist: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    
    var currentIndex = 0
    var popupView = PopUpView()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isPlaying = false
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        playingMusicArtist.text = musicList[0].artist
        playingMusicTitle.text = musicList[0].title
        playingMusicImageView.image = musicList[0].albumImage
        
        self.playingMusicImageView.clipsToBounds = true
        self.playingMusicImageView.layer.cornerRadius = self.playingMusicImageView.frame.width / 2
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isPlaying == true {
            playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playBtn.tintColor = UIColor.darkGray
        } else {
            playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            playBtn.tintColor = UIColor.darkGray
        }
        
    }
    
    @objc func updateProgressView() {
        if Service.instance.player.isPlaying {
            popupView.progressBar.setProgress(Float(Service.instance.player.currentTime / Service.instance.player.duration), animated: true)
        }
    }
    
    func changePlayerCondition(index: Int) {
        popupView.albumImageView.image = musicList[index].albumImage
        popupView.titleLabel.text = musicList[index].title
        popupView.artistLabel.text = musicList[index].artist
        
        self.playingMusicTitle.text = musicList[index].title
        self.playingMusicArtist.text = musicList[index].artist
        self.playingMusicImageView.image = musicList[index].albumImage
    }
    
    func setUpPopUpView() {
        view.addSubview(popupView)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        popupView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        popupView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if isPlaying == true {
            popupView.playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            popupView.playBtn.tintColor = UIColor.darkGray
        } else {
            popupView.playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            popupView.playBtn.tintColor = UIColor.darkGray
        }
    }
    
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        if Service.instance.player.isPlaying {
            Service.instance.player.pause()
            isPlaying = false
            playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            playBtn.tintColor = UIColor.darkGray
            popupView.playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            popupView.playBtn.tintColor = UIColor.darkGray
        } else {
            playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playBtn.tintColor = UIColor.darkGray
            popupView.playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            popupView.playBtn.tintColor = UIColor.darkGray
            Service.instance.player.play()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        if currentIndex != 0 {
            Service.instance.playSound(title: musicList[currentIndex - 1].title, artist: musicList[currentIndex - 1].artist)
            changePlayerCondition(index: currentIndex - 1)
            currentIndex = currentIndex - 1
        } else {
            Service.instance.playSound(title: musicList[currentIndex].title, artist: musicList[currentIndex].artist)
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if currentIndex != musicList.count - 1 {
            Service.instance.playSound(title: musicList[currentIndex + 1].title, artist: musicList[currentIndex + 1].artist)
            changePlayerCondition(index: currentIndex + 1)
            currentIndex = currentIndex + 1
        } else {
            Service.instance.playSound(title: musicList[currentIndex].title, artist: musicList[currentIndex].artist)
        }
        
        
    }
    
    @IBAction func showPopUpBtnPressed(_ sender: Any) {
        setUpPopUpView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListCell else { return UITableViewCell() }
        let music = musicList[indexPath.row]
        cell.selectionStyle = .gray
        cell.configureCell(image: music.albumImage, title: music.title, artist: music.artist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let music = musicList[indexPath.row]
        currentIndex = indexPath.row
        Service.instance.playSound(title: music.title, artist: music.artist)
        isPlaying = true
        setUpPopUpView()
        popupView.albumImageView.image = music.albumImage
        popupView.titleLabel.text = music.title
        popupView.artistLabel.text = music.artist
        self.playingMusicTitle.text = music.title
        self.playingMusicArtist.text = music.artist
        self.playingMusicImageView.image = music.albumImage
        self.playBtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        self.playBtn.tintColor = UIColor.darkGray
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        
    }
    
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        playBtn.tintColor = UIColor.darkGray
        isPlaying = false
    }
    
}






