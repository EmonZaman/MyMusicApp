//
//  MusicPlayerViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 16/11/22.
//

import UIKit

import AVFoundation
import AVKit

class PlayListPlaySongsViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [MusicData] = []
    @IBOutlet weak var holder2: UIView!
    var player: AVAudioPlayer?
    var timer: Timer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    private let albumNameLabel: UILabel = {
        let songName = UILabel()
        songName.textAlignment = .center
        songName.numberOfLines = 0
        
        return songName
    }()
    let playPauseButton = UIButton()
    let uiSlider = UISlider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("!!!!!!!@@@@@!!!!!!!")
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder2.subviews.count == 0{
            configure()
        }
    }
    
    func loadSongFromDocumentDirectory(nameOfSong: String ) -> URL?{
        if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            //This gives you the URL of the path
            
            
            return documentsPathURL.appendingPathComponent(nameOfSong)
            
//            let file = FileManager.default
//            file.removeItem(at: documentsPathURL)
            
            
        }
        return nil
        
        
    }
    
    //    private func playVideo(url:URL) {
    //
    //        let player = AVPlayer(url: url)
    //       // let player = AVPlayer(url: url)
    //
    //        print(url)
    //
    //
    //        player.play()
    //    }
    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        print(paths.first)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image ?? UIImage(named: "1")!
        }
        return UIImage.init(named: "1")!
    }
    func playMusic(url: URL) {
        print("url is \(url)")
        print("This is played")
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func configure(){
        let song = songs[position]
        
        
        
        //  let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        print("Url string")
        //        print("\(urlString)")
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            //            guard let urlString = urlString else
            //            {
            //                print("URL returning")
            //                return
            //            }
            
            print(song.songUrl)
            var url: URL?
            
            
            if let name = song.songUrl, let url1 =
                loadSongFromDocumentDirectory(nameOfSong:name ){
                url = url1
                
                //  self.playVideo(url: url)
                print("playMusuc Url")
                print(url1)
                player = try AVAudioPlayer(contentsOf: url!)
                uiSlider.value = 0.0
                uiSlider.maximumValue = Float((player?.duration)!)
                player?.play()
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                
                guard let player = player else{
                    print("playing return " )
                    return
                }
                print("playing1")
                player.volume = 0.5
                player.play()
                print("playing")
                // return
                
                //                player = try AVAudioPlayer(contentsOf: url)
            }
            
            //            player = try AVAudioPlayer(contentsOf: URL(string: song.trackName!)!)
            // player = try AVAudioPlayer(contentsOf: "song2")
            
            
            //            uiSlider.value = 0.0
            //            uiSlider.maximumValue = Float((player!.duration))
            //            player?.play()
            //            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            //
            //            guard let player = player else{
            //                print("playing return " )
            //                return
            //            }
            //            print("playing1")
            //            player.volume = 0.5
            //            player.play()
            //            print("playing")
            
            
        }
        catch{
            print("error occured")
            
        }
        //Album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder2.frame.size.width-20,
                                      height: holder2.frame.size.width-20)
        var image = loadImageFromDocumentDirectory(nameOfImage: song.image ?? "")
        albumImageView.image = image
        holder2.addSubview(albumImageView)
        
        //Labels : songName, album,, artist
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height,
                                     width: holder2.frame.size.width-20,
                                     height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 50,
                                      width: holder2.frame.size.width-20,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height  + 100,
                                       width: holder2.frame.size.width-20,
                                       height: 70)
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        holder2.addSubview(songNameLabel)
        holder2.addSubview(albumNameLabel)
        holder2.addSubview(artistNameLabel)
        
        
        //player controllers
        
        
        let nextButton = UIButton()
        let backButton = UIButton()
        //play Pause forward back button Button Action
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButttton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapForwardButttton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButttton), for: .touchUpInside)
        
        //play Pause forward back button Buttton Frame
        
        let yPosition = artistNameLabel.frame.origin.y + 100 + 20
        let size: CGFloat = 70
        playPauseButton.frame = CGRect(x: (holder2.frame.size.width - size) / 2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder2.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
        
        
        //styling for play Pause forward back button and color
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder2.addSubview(playPauseButton)
        holder2.addSubview(nextButton)
        holder2.addSubview(backButton)
        
        //slider volume
        let slider = UISlider(frame: CGRect(x: 20, y: holder2.frame.size.height-60, width: holder2.frame.size.width-40, height: 50))
        slider.value = 0.5
        slider.tintColor = .red
        slider.backgroundColor = .black
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged    )
        holder2.addSubview(slider)
        
        //Progress Bar
        
        
        uiSlider.frame = CGRect(x: 20, y: holder2.frame.size.height-240, width: holder2.frame.size.width-40, height: 50)
        // uiSlider.value = 0.0
        uiSlider.tintColor = .black
        uiSlider.addTarget(self, action: #selector(progressBar(_:)), for: .valueChanged)
        holder2.addSubview(uiSlider)
        // progress bar
        //        let updater = CADisplayLink(target: self, selector: #selector(self.musicProgress))
        //                updater.frameInterval = 1
        //
        //                updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        //
        //        holder.addSubview(updater)
        
        
        
    }
    
    @objc func didTapPlayPauseButttton(){
        print("back Postion \(position)")
        
        
        
        if player?.isPlaying == true{
            // pause this
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink Image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder2.frame.size.width-60,
                                                   height: self.holder2.frame.size.width-60)
                
            })
        }
        else
        {
            //play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            //Increase image view
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder2.frame.size.width-20,
                                                   height: self.holder2.frame.size.width-20)
                
            })
            
        }
    }
    @objc func progressBar(_ slider: UISlider){
        uiSlider.maximumValue = Float(player?.duration ?? 0)
        player?.stop()
        player?.currentTime = TimeInterval(uiSlider.value)
        player?.prepareToPlay()
        player?.play()
    }
    @objc func didTapBackButttton(){
        print("forward Postion \(position)")
        
        if position > 0{
            position = position - 1
            player?.stop()
            for subview in holder2.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    @objc func didTapForwardButttton(){
        if position <  (songs.count - 1 ){
            position = position + 1
            player?.stop()
            for subview in holder2.subviews{
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    //    @objc func musicProgress()  {
    //
    //        let normalizedTime = Float(self.player?.currentTime as! Double / (self.player?.duration as! Double) )
    //        self.progressMusic.progress = normalizedTime
    //    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        if let player = player {
        //            player.stop()
        //        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    @objc func updateSlider(){
        
        uiSlider.value = Float(player?.currentTime ?? 0)
        //print("It works")
        // print(uiSlider.value)
    }
    
}

