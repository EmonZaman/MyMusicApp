//
//  PlayListViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 24/11/22.
//

import UIKit
//struct PlayList{
//    var name: String?
//}
var playLists = [Playlist]()

protocol PlayListDelegate: AnyObject {
    func deletePlayList()
}

class PlayListViewController: UIViewController {
    
    
    
    @IBOutlet weak var playListView: UICollectionView!
    let context = PersistentStorage.shared.context
    // var playLists = [PlayList]()
    
    
    
    
    func playListLoad(){
        do {
            
            guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
            print("data Converting start")
            playLists.removeAll()
            
            result.forEach { playlist in
                
                  playLists.append(playlist)
                
            }
            
            
        } catch let error {
            debugPrint(error)
        }
        
    }
    func currentData(){
        print("current data")
        playLists = PersistentStorage.shared.playlists()
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        print("PLAYLIUST DIDLOAD")
        super.viewDidLoad()
          playListLoad()
        navigationItem.title = "Playlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        print("Playlist view controller callled")
        let layout = UICollectionViewFlowLayout()
        
        //layout.itemSize = CGSize(width: 120, height: 120)
        playListView.collectionViewLayout = layout
        playListView.delegate = self
        playListView.dataSource = self
      //  playLists = PersistentStorage.shared.playlists()
    }
    var tField: UITextField!
    
    @IBAction func btnPlayListAdd(_ sender: UIBarButtonItem) {
        
        
        func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Playlist Name"
            tField = textField
            
        }
        
        func handleCancel(alertView: UIAlertAction!)
        {
            print("Cancelled !!")
        }
        
        var alert = UIAlertController(title: "Enter Playlist Name", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler:{ (UIAlertAction) in
            print("Done !!")
            
            print("Item : \(self.tField.text)")
            // let newData = Playlist(context: self.context)
            //  newData.name = self.tField.text
            // newData.addToMusic(<#T##value: MusicData##MusicData#>)
            //   self.playLists.append(PlayList(name: self.tField.text))
            
            //              let playlist = PersistentStorage.shared.playlist(name: self.tField.text ?? "null")
            //              playLists.append(playlist)
            //
            //              PersistentStorage.shared.saveContext()
            //              self.playListView.reloadData()
            checkDuplicate()
            
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
        func checkDuplicate(){
            print("The file already exists at path")
            var rr = 0
            do {
                
                guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
                
                
                
                
                result.forEach { playlist in
                    print("in")
                    if playlist.name == tField.text{
                        rr = 1
                        print("The file already exists at path")
                        
                        let alertController = UIAlertController(title: "Alert", message: "There is a Playlist with same name already exists in your app Choose Another", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true)
                        return
                        
                    }
                    
                    
                }
                if rr == 0 {
                    let playlist = PersistentStorage.shared.playlist(name: self.tField.text ?? "null")
                    playLists.append(playlist)
                    
                    PersistentStorage.shared.saveContext()
                    self.playListView.reloadData()
                    
                }
                
                
                
            } catch let error {
                debugPrint(error)
            }
            
            
        }
        
        
        
    }
    
    
    
}
extension PlayListViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("This is tapped")
        print("\(indexPath.row)")
        
        if let vc = storyboard?.instantiateViewController(identifier: "playListSongsViewController") as? playListSongsViewController{
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
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
    
}
extension PlayListViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of Item in section")
        self.playListLoad()
      //  playLists = PersistentStorage.shared.playlists()
        print("TOTAL PLAY LIST")
        print(playLists.count)
        return playLists.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for ROw Called")
        print("crash start")
        let cell = playListView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayListCollectionViewCell
        print("HERE")
       // var songs = PersistentStorage.shared.songs(playlist: playLists[indexPath.row])
        var songs = playLists[indexPath.row].songs
        var i = 0
        var check = 0
        songs?.forEach({ song in
            print("SONG LIST")
            print(song)
            if(i == (songs!.count) - 1){
            
                print("here it comes")
                var song = song as! MusicData
                let image = loadImageFromDocumentDirectory(nameOfImage: song.image ??  "1")
                
                cell.lastImage.image = image
                check = 1
                
            }
            i += 1
        })
           
            
        
        if check == 0{
            cell.lastImage.image = UIImage(named: "1")
        }
        cell.playList = playLists[indexPath.row]
        cell.delegate = self
        
        cell.playListName.text = playLists[indexPath.row].name
        cell.playListName.textColor = .white
        cell.playListName.backgroundColor = .black
        // self.playListView.reloadData()
        currentData()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width/4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.playListView.reloadData()
      //  playLists = PersistentStorage.shared.playlists()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.playListView.reloadData()
    }
    
    
    
}


extension PlayListViewController: PlayListDelegate {
    func deletePlayList() {
       // playLists = PersistentStorage.shared.playlists()
        self.playListView.reloadData()
        
    }
}
