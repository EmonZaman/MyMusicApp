//
//  playListSongsViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 24/11/22.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation
import MediaToolbox
import MediaPlayer
import CoreData


class playListSongsViewController: UIViewController, MPMediaPickerControllerDelegate {
    var songs = [MusicData]()
    var index = Int()
    var playlist: Playlist?
    let context = PersistentStorage.shared.context
    

   @IBOutlet weak var tblForPlayListSongs: UITableView!
  //  @IBAction func musicAddButtonClick(_ sender: UIButton) {
//        print("music is adding")
//
//        let controller = MPMediaPickerController(mediaTypes: .music)
//        controller.allowsPickingMultipleItems = false
//        controller.popoverPresentationController?.sourceView = sender
//        controller.delegate = self
//        present(controller, animated: true)
//
//    }
//    init(index: Int) {
//            self.index = index
//            playlist = playLists[index]
//            super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
       
    
//    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
//        mediaPicker.dismiss(animated: true) {
//            
//            print("You selected \(mediaItemCollection)")
//            
//            let item: MPMediaItem = mediaItemCollection.items[0]
//            let title = item.title
//            let size = CGSize(width: 20, height: 30)
//            let thumbImage = item.artwork?.image(at: size)
//            print(thumbImage)
//            print("trackCount \(item.albumTrackCount)")
//            print("trackCount \(item.artwork)")
//            print("trackCount \(item.artist)")
//            print("trackCount \(item.albumTitle)")
//            let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
//            if pathURL == nil {
//                print("Picking Error")
//                return
//            }
//            // get file extension andmime type
//            let str = pathURL!.absoluteString
//            let str2 = str.replacingOccurrences( of : "ipod-library://item/item", with: "")
//            let arr = str2.components(separatedBy: "?")
//            var mimeType = arr[0]
//            mimeType = mimeType.replacingOccurrences( of : ".", with: "")
//            
//            // Export the ipod library as .m4a file to local directory for remote upload
//            let exportSession = AVAssetExportSession(asset: AVAsset(url: pathURL!), presetName: AVAssetExportPresetAppleM4A)
//            exportSession?.shouldOptimizeForNetworkUse = true
//            exportSession?.outputFileType = AVFileType.m4a
//            
//            guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//            
//            guard let title else{return}
//            let outputURL = documentURL.appendingPathComponent("\(title).m4a")
//            
//            if FileManager.default.fileExists(atPath: outputURL.path) {
//                print("The file already exists at path")
//                
//                let alertController = UIAlertController(title: "Alert", message: "This song is already exists in your player Choose another", preferredStyle: .alert)
//                
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true)
//                return
//                //                return
//                
//            }
//            
//            print("OUTPUT \(outputURL)")
//            // let newData = MusicData(context: self.context)
//            do {
//                // after downloading your file you need to move it to your destination url
//                // try FileManager.default.moveItem(at: documentURL, to: outputURL)
//                //self.playMusic(url: destinationUrl)
//                print("destination URL")
//                print(outputURL)
//                //  let MusicInfo = MusicData(context: PersistentStorage.shared.context)
//                //                let newData = MusicData(context: self.context)
//                //                let song = DataManager.shared.song(title: titleTextField.text ?? "", releaseDate: releaseDateTextField.text ?? "", singer: singer!)
//               // playlist = "Running"
//                let newData = MusicData(context: self.context)
//                
//                newData.name = title
//                print("PLAYYYY LISTTT \(self.playlist)")
//                newData.playlist = self.playlist
//             
//                newData.id = UUID()
//               
//                
//                
//                //  newData.id = UUID()
//                // newData.name = title
//                //   newData.songUrl = title + ".m4a"
//                //  newData.artistName = item.artist
//                if thumbImage != nil{
//                      newData.image = self.saveImageToDocumentDirectory(image: thumbImage, id: newData.id)
//                    
//                }
//                do {
//                    try PersistentStorage.shared.saveContext()
//                    let song = PersistentStorage.shared.musicData(name: title, artist: item.artist ?? "aa", songUrl: title + ".m4a", image: newData.im, playlist: self.playlist!)
//                    self.songs.append(song)
//                    print(self.songs)
//                    PersistentStorage.shared.saveContext()
//                    self.tblForPlayListSongs.reloadData()
//                } catch {
//                    print("Error")
//                    
//                }
//                
//                // self.data.insert(newData, at: 0)
//                
//                print("File moved to documents folder")
//                //                if thumbImage != nil{
//                //                    self.songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: item.artist, image: "3", trackName: (title + ".m4a"), thumbImgae: thumbImage ))
//                //
//                //                }
//                //                else{
//                //                    self.songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: item.artist, image: "3", trackName: (title + ".m4a"), thumbImgae:  UIImage(named: "1") ))
//                //
//                //                }
//                
//                
//                //  PersistentStorage.shared.saveContext()
//                //                     /   convertMusicTODatia()
//                //  self.table.backgroundView?.alpha = 0
//                
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
//    }
//    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
//        mediaPicker.dismiss(animated: true) {
//            
//            print("You selected \(mediaItemCollection)")
//            
//            let item: MPMediaItem = mediaItemCollection.items[0]
//            let title = item.title
//            let size = CGSize(width: 20, height: 30)
//            let thumbImage = item.artwork?.image(at: size)
//            print(thumbImage)
//            print("trackCount \(item.albumTrackCount)")
//            print("trackCount \(item.artwork)")
//            print("trackCount \(item.artist)")
//            print("trackCount \(item.albumTitle)")
//            let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
//            if pathURL == nil {
//                print("Picking Error")
//                return
//            }
//            // get file extension andmime type
//            let str = pathURL!.absoluteString
//            let str2 = str.replacingOccurrences( of : "ipod-library://item/item", with: "")
//            let arr = str2.components(separatedBy: "?")
//            var mimeType = arr[0]
//            mimeType = mimeType.replacingOccurrences( of : ".", with: "")
//            
//            // Export the ipod library as .m4a file to local directory for remote upload
//            let exportSession = AVAssetExportSession(asset: AVAsset(url: pathURL!), presetName: AVAssetExportPresetAppleM4A)
//            exportSession?.shouldOptimizeForNetworkUse = true
//            exportSession?.outputFileType = AVFileType.m4a
//            
//            guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//            
//            guard let title else{return}
//            let outputURL = documentURL.appendingPathComponent("\(title).m4a")
//            
//            if FileManager.default.fileExists(atPath: outputURL.path) {
//                print("The file already exists at path")
//                
//                do {
//                   
//                    guard let result =   try PersistentStorage.shared.context.fetch(MusicData.fetchRequest()) as? [MusicData] else {return}
//                    print("data Converting start")
//                    var urlString: String?
//                    print("\(urlString)")
//                    var image: UIImage?
//                    var check = 0
//                    result.forEach { MusicData in
//                        print("data Converting rrr")
//                        if(MusicData.name == title)
//                         {
//                            print("EXITSSSSSSSSSSSSS")
//                            
//                            check = 1
//                            self.playlist?.addToSongs(MusicData)
//                            PersistentStorage.shared.saveContext()
//                            self.tblForPlayListSongs.reloadData()
//                            return
//                            
//                        }
//                   
//                        
//                        print("fetching data ",urlString)
//                    }
//                   
//                    
//                    
//                } catch let error {
//                    debugPrint(error)
//                }
//
//                
//                let alertController = UIAlertController(title: "Alert", message: "This song is already in your playlist", preferredStyle: .alert)
//                
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true)
//                return
//                //                return
//                
//            }
//            
//            print("OUTPUT \(outputURL)")
//           // let newData = MusicData(context: self.context)
//            do {
//                // after downloading your file you need to move it to your destination url
//                // try FileManager.default.moveItem(at: documentURL, to: outputURL)
//                //self.playMusic(url: destinationUrl)
//                print("destination URL")
//                print(outputURL)
//                //  let MusicInfo = MusicData(context: PersistentStorage.shared.context)
//                //                let newData = MusicData(context: self.context)
////                newData.id = UUID()
////                newData.name = title
////                newData.songUrl = title + ".m4a"
////                newData.artistName = item.artist
//                let id = UUID()
//                var imageName: String?
//                if thumbImage != nil{
//                     imageName = self.saveImageToDocumentDirectory(image: thumbImage, id: id)
//                    print(imageName)
//                    let song = PersistentStorage.shared.musicData(name: title ?? "none", artist: item.artist!, songUrl: title + ".m4a", image: imageName ?? "1" , playlist: self.playlist!)
//                    print(song)
//                    self.songs.append(song)
//                    self.tblForPlayListSongs.reloadData()
//                    PersistentStorage.shared.saveContext()
//                }
//                else{
//                     //imageName = self.saveImageToDocumentDirectory(image: thumbImage, id: id)
//                    let defaultImage = UIImage(named: "1")
//                    imageName = self.saveImageToDocumentDirectory(image: defaultImage, id: id)
//                    let song = PersistentStorage.shared.musicData(name: title , artist: item.artist ?? "Unknown Artis", songUrl: title + ".m4a", image: imageName ?? "1", playlist: self.playlist!)
//                    print(song)
//                    self.songs.append(song)
//                    self.tblForPlayListSongs.reloadData()
//                    PersistentStorage.shared.saveContext()
//                }
               
                
//                do {
//                    try PersistentStorage.shared.saveContext()
//                } catch {
//                    print("Error")
//
//                }
                
             //   self.data.insert(newData, at: 0)
                
//                print("File moved to documents folder")
//               
//              //  self.table.backgroundView?.alpha = 0
//                
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//            
//       
//            self.tblForPlayListSongs.reloadData()
//            
//            
//            
//            
//            //Delete Existing file
//            do {
//                try FileManager.default.removeItem(at: outputURL)
//            } catch let error as NSError {
//                print(error.debugDescription)
//            }
//            
//            exportSession?.outputURL = outputURL
//            exportSession?.exportAsynchronously(completionHandler: { () -> Void in
//                
//                if exportSession!.status == AVAssetExportSession.Status.completed  {
//                    print("Export Successfull")
//                    
//                    
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                        // self.playVideo(url: outputURL)
//                    }
//                    
//                }
//                
//                
//            }
//                                                
//            )
//            
//            
//            
//        }
//        
//        
//    }
    
    func saveImageToDocumentDirectory(image: UIImage?, id: UUID? ) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(id).jpeg"// name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image?.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileName
            } catch {
                print("error saving file:", error)
            }
        }
        return nil
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

    override func viewDidLoad() {
        
       // dataLoad()
//        navigationItem.title = "PlayList1"
//        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        print("index")
        print(self.index)
        
        playlist = playLists[self.index]
        print("playlist \(playlist)")
        print(playlist)
        
        let nib = UINib(nibName: "PlayListSongsTableViewCell", bundle: nil)
        tblForPlayListSongs.register(nib, forCellReuseIdentifier: "cell")
        
        tblForPlayListSongs.delegate = self
        tblForPlayListSongs.dataSource = self
        if let playlist = playlist {
            
            
//            songs = PersistentStorage.shared.songs(playlist: playlist)
            songs = PersistentStorage.shared.songs(playlist: playlist)
            print("all songs in same playlist")
            print(songs)

        }
        tblForPlayListSongs.reloadData()

        // Do any additional setup after loading the view.
    }
    



}

extension playListSongsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you just tapped")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayListPlaySongsViewController") as? PlayListPlaySongsViewController else {
               return
           }
           
           vc.position = indexPath.row
           print(indexPath.row)
        
           
           vc.songs = songs

           present(vc, animated: true)
    }
    
}
extension playListSongsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        let cell = tblForPlayListSongs.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayListSongsTableViewCell

        var image = loadImageFromDocumentDirectory(nameOfImage: song.image ?? "")
            

            
     

        cell.lblPlayListSongDetails.text = song.artistName
        cell.lblPlayListSongName.text = song.name
        cell.mImgPlayListVIew.image = image
       
        cell.lblPlayListSongName?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.lblPlayListSongDetails?.font = UIFont(name: "Helvetica", size: 17)
    
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70    }
        
}
