//
//  ViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 16/11/22.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation
import MediaToolbox
import MediaPlayer
import CoreData
protocol MyDataSendingToCell {
    func sendData(name: String , albumName: String, artistname: String, image: String, trackName: String, thumbImgae: String)
}
struct Song{
    
    let name: String
    let albumName: String?
    let artistname: String?
    let image: String?
    let trackName: String?
    let thumbImgae: UIImage?
    
}


class ViewController: UIViewController, MPMediaPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIDocumentPickerDelegate {
    @IBAction func emptyAddButton(_ sender: UIButton) {
        print("adding music®")
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.allowsPickingMultipleItems = false
        controller.popoverPresentationController?.sourceView = sender
        controller.delegate = self
        present(controller, animated: true)
    }
    
    
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    @IBAction func onAddButtonClick(_ sender: UIButton) {
        print("music is adding")
        
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.allowsPickingMultipleItems = false
        controller.popoverPresentationController?.sourceView = sender
        controller.delegate = self
        present(controller, animated: true)
        
        //for documnet picker
        //     var documentPicker: UIDocumentPickerViewController
        //
        //        //var documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        //        if #available(iOS 14.0, *) {
        //            let supportedTypes: [UTType] = [UTType.audio]
        //            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        //        } else {
        //            documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        //        }
        //        documentPicker.delegate = self
        //        self.present(documentPicker, animated: true, completion: nil)
    }
    let context = PersistentStorage.shared.context
    var delegate: MyDataSendingToCell?
    
    
    var data = [MusicData]()
    var songs = [Song]()
    var player2: AVAudioPlayer?
    private func playVideo(url:URL) {
        
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            
        }
        
        let player = AVPlayer(url: url)
        
        print(url)
        
        
        player.play()
    }
    
    override func viewDidLoad() {
        
        // dataLoad()
        convertMusicTOData()
        navigationItem.title = "MyMusic"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        super.viewDidLoad()
        
        
        print("printing data")
        // Do any additional setup after loading the view.
        if songs.count == 0 {
            // tableView is empty. You can set a backgroundView for it.
            print("data is empty .............")
//            navigationItem.title = "MyMusic"
            
            emptyViewFunc()
            table.delegate = self
            table.dataSource = self
            
        }
        else
        {
            table.delegate = self
            table.dataSource = self
            
          
            
        }
    }
    
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPicker.dismiss(animated: true) {
            
            print("You selected \(mediaItemCollection)")
            
            let item: MPMediaItem = mediaItemCollection.items[0]
            let title = item.title
            let size = CGSize(width: 20, height: 30)
            let thumbImage = item.artwork?.image(at: size)
            print(thumbImage)
            print("trackCount \(item.albumTrackCount)")
            print("trackCount \(item.artwork)")
            print("trackCount \(item.artist)")
            print("trackCount \(item.albumTitle)")
            let pathURL: URL? = item.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
            if pathURL == nil {
                print("Picking Error")
                return
            }
            // get file extension andmime type
            let str = pathURL!.absoluteString
            let str2 = str.replacingOccurrences( of : "ipod-library://item/item", with: "")
            let arr = str2.components(separatedBy: "?")
            var mimeType = arr[0]
            mimeType = mimeType.replacingOccurrences( of : ".", with: "")
            
            // Export the ipod library as .m4a file to local directory for remote upload
            let exportSession = AVAssetExportSession(asset: AVAsset(url: pathURL!), presetName: AVAssetExportPresetAppleM4A)
            exportSession?.shouldOptimizeForNetworkUse = true
            exportSession?.outputFileType = AVFileType.m4a
            
            guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            
            guard let title else{return}
            let outputURL = documentURL.appendingPathComponent("\(title).m4a")
            
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
            
            print("OUTPUT \(outputURL)")
            let newData = MusicData(context: self.context)
            do {
                // after downloading your file you need to move it to your destination url
                // try FileManager.default.moveItem(at: documentURL, to: outputURL)
                //self.playMusic(url: destinationUrl)
                print("destination URL")
                print(outputURL)
                //  let MusicInfo = MusicData(context: PersistentStorage.shared.context)
                //                let newData = MusicData(context: self.context)
                newData.id = UUID()
                newData.name = title
                newData.songUrl = title + ".m4a"
                newData.artistName = item.artist
                if thumbImage != nil{
                    newData.image = self.saveImageToDocumentDirectory(image: thumbImage, id: newData.id)
                }
                do {
                    try PersistentStorage.shared.saveContext()
                } catch {
                    print("Error")
                    
                }
                
                self.data.append(newData)
                print("File moved to documents folder")
               
                self.table.backgroundView?.alpha = 0
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            if thumbImage != nil{
                self.songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: item.artist, image: "3", trackName: (title + ".m4a"), thumbImgae: thumbImage ))
                
                
            }
            else{
                self.songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: item.artist, image: "3", trackName: (title + ".m4a"), thumbImgae:  UIImage(named: "1") ))
                
            }
            self.table.reloadData()
            
            
            
            
            //Delete Existing file
            do {
                try FileManager.default.removeItem(at: outputURL)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
            exportSession?.outputURL = outputURL
            exportSession?.exportAsynchronously(completionHandler: { () -> Void in
                
                if exportSession!.status == AVAssetExportSession.Status.completed  {
                    print("Export Successfull")
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        // self.playVideo(url: outputURL)
                    }
                    
                }
                
                
            }
                                                
            )
            
            
            
        }
        
        
    }
    func saveImageToDocumentDirectory(image: UIImage?, id: UUID? ) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(id).jpeg" // name of the image to be saved
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
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true)
    }
    
    
    // for File Copy this lines
    func importFormFile(){
        var documentPicker: UIDocumentPickerViewController
        
        //var documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        if #available(iOS 14.0, *) {
            let supportedTypes: [UTType] = [UTType.audio]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        }
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    //core Data
    
    func convertMusicTOData(){
        do {
//            self.songs.append(Song(name: "test1", albumName: "test1", artistname: "test1", image: "1", trackName: "song1", thumbImgae: UIImage(named: "1")))
//            self.songs.append(Song(name: "test1", albumName: "test1", artistname: "test1", image: "1", trackName: "song1", thumbImgae: UIImage(named:  "1")))
              self.data.removeAll()
              self.songs.removeAll()
           
            guard let result =   try PersistentStorage.shared.context.fetch(MusicData.fetchRequest()) as? [MusicData] else {return}
            print("data Converting start")
            var urlString: String?
            print("\(urlString)")
            var image: UIImage?
            result.forEach { MusicData in
                print("data Converting rrr")
                if(MusicData.image != nil){
                    image = loadImageFromDocumentDirectory(nameOfImage: MusicData.image ?? "")
                    self.data.append(MusicData)
                    songs.append(Song(name: MusicData.name ?? "tt" , albumName: MusicData.albumName, artistname: MusicData.artistName, image: "3", trackName: MusicData.songUrl, thumbImgae: image ))
                }
                else
                {
                    print("else is called")
                    self.data.append(MusicData)
                    songs.append(Song(name: MusicData.name ?? "tt" , albumName: MusicData.albumName, artistname: MusicData.artistName, image: "3", trackName: MusicData.songUrl, thumbImgae: UIImage(named: "1") ))
                }
                
                print("fetching data ",urlString)
            }
            
            
        } catch let error {
            debugPrint(error)
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
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        let asset = AVURLAsset(url: url)
        guard asset.isComposable else {
            print("Your music is Not Composible")
            return
        }
        
        
        
        
        print("url111111111111111 \(url)")
        addAudio(audioUrl: url)
    }
    
    func addAudio(audioUrl: URL) {
        // then lets create your document folder url
        print("document url")
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL)
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        print(destinationUrl)
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
            self.playMusic(url: destinationUrl)
        } else {
            // if the file doesn't exist you can use NSURLSession.sharedSession to download the data asynchronously
            //                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
            //
            //
            //                    debugPrint(error?.localizedDescription)
            //
            //
            //                    guard let location = location, error == nil else { return }
            //
            //                    do {
            //                        // after downloading your file you need to move it to your destination url
            //                        try FileManager.default.moveItem(at: location, to: destinationUrl)
            //                        //self.playMusic(url: destinationUrl)
            //                        print("File moved to documents folder")
            //                    } catch let error as NSError {
            //                        print(error.localizedDescription)
            //                    }
            //                }).resume()
            do {
                // after downloading your file you need to move it to your destination url
                try FileManager.default.moveItem(at: audioUrl, to: destinationUrl)
                //self.playMusic(url: destinationUrl)
                print("destination URL")
                print(destinationUrl)
                //  let MusicInfo = MusicData(context: PersistentStorage.shared.context)
                let newData = MusicData(context: self.context)
                
                newData.name = "test1"
                //   newData.songUrl = destinationUrl
                newData.artistName = "artist"
                
                
                do {
                    try PersistentStorage.shared.saveContext()
                } catch {
                    print("Error")
                    
                }
                
                self.data.insert(newData, at: 0)
                
                
                print("File moved to documents folder")
                // songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: "Lincon", image: "3", trackName: newData.songUrl ))
                
                //  PersistentStorage.shared.saveContext()
                //                     /   convertMusicTOData()
                table.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    func addMediaAudio(audioUrl: URL) {
        // then lets create your document folder url
        print("document url")
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL)
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        print(destinationUrl)
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
            self.playMusic(url: destinationUrl)
        } else {
            // if the file doesn't exist you can use NSURLSession.sharedSession to download the data asynchronously
            //                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
            //
            //
            //                    debugPrint(error?.localizedDescription)
            //
            //
            //                    guard let location = location, error == nil else { return }
            //
            //                    do {
            //                        // after downloading your file you need to move it to your destination url
            //                        try FileManager.default.moveItem(at: location, to: destinationUrl)
            //                        //self.playMusic(url: destinationUrl)
            //                        print("File moved to documents folder")
            //                    } catch let error as NSError {
            //                        print(error.localizedDescription)
            //                    }
            //                }).resume()
            
            
            do {
                // after downloading your file you need to move it to your destination url
                try FileManager.default.moveItem(at: audioUrl, to: destinationUrl)
                //self.playMusic(url: destinationUrl)
                print("destination URL")
                print(destinationUrl)
                //  let MusicInfo = MusicData(context: PersistentStorage.shared.context)
                let newData = MusicData(context: self.context)
                
                newData.name = "test1"
                //   newData.songUrl = destinationUrl
                newData.artistName = "artist"
                do {
                    try PersistentStorage.shared.saveContext()
                } catch {
                    print("Error")
                }
                self.data.insert(newData, at: 0)
                print("File moved to documents folder")
                songs.append(Song(name: newData.name ?? "tt" , albumName: "Artcell", artistname: "Lincon", image: "3", trackName: newData.songUrl, thumbImgae: UIImage(named: "1")))
                //  PersistentStorage.shared.saveContext()
                //                     /   convertMusicTOData()
                table.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func playMusic(url: URL) {
        print("url is \(url)")
        print("This is played")
        do {
            player2 = try AVAudioPlayer(contentsOf: url)
            player2?.prepareToPlay()
            player2?.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func emptyViewFunc(){
        table.backgroundView = emptyView
        self.table.backgroundView?.alpha = 1
        //  table.reloadData()
        
        print("empty viw Called")
    }
    func notEmpty(){
        table.delegate = self
        table.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerCell
        
        print("HERE IS THE PROBLEM")
        
        let song = self.data[indexPath.row]
        
//        self.delegate?.sendData(name: song.name ?? "name", albumName: song.albumName ?? "album", artistname: song.albumName!, image: song.image ?? " ", trackName: song.songUrl ?? " ", thumbImgae: song.image ?? " ")
        
        cell.song = song
        cell.lblSongName.text = songs[indexPath.row].name
        
        // cell.mImgVIew.image = UIImage(named: songs[indexPath.row].image!)
        cell.mImgVIew.image = songs[indexPath.row].thumbImgae
        cell.accessoryType = .disclosureIndicator
        cell.lblSongDetails.text = songs[indexPath.row].artistname
        
        cell.lblSongName?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.lblSongDetails?.font = UIFont(name: "Helvetica", size: 17)
      //  cell.folder = self.playlist
        print("THis")
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MusicPlayerViewController") as? MusicPlayerViewController else {
            return
        }
        
        vc.position = indexPath.row
        print(indexPath.row)
        
        vc.songs = songs
        print(songs[indexPath.row].name)
        print(songs[indexPath.row].trackName)
        present(vc, animated: true)
        print("you just tapped")
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70    }
    func DeleteSongFromDocumentDirectory(nameOfSong: String ) {
            if var documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            //This gives you the URL of the path
            
            
            let outputUrl =  documentsPathURL.appendingPathComponent(nameOfSong)
            print("name if song \(nameOfSong)")
            print("DELETING")
            print(documentsPathURL)
            
            let file = FileManager.default
            print("Image \(file)")
            do{
                try file.removeItem(at: outputUrl)
                print("Deleting Complete..")
                print("delete ccc...")
            }
            catch{
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // let MusicInfo = MusicData(context: PersistentStorage.shared.context)
        // PersistentStorage.shared.context.saveContext()
        print(indexPath.row)
        print("DTATA")
       // print(self.data[0])
        
        if editingStyle == .delete {
            print("Deleted")
          // DeleteSongFromDocumentDirectory(nameOfSong: songs[indexPath.row].trackName ?? "none")
            
            
            let songremove = self.data[indexPath.row]
            
            print("your are deleting this items")
            print("index path \(indexPath.row)")
            print("total data \(data.count)")
            print(data[indexPath.row].name)
            print(data[indexPath.row].image)
            
            
            PersistentStorage.shared.context.delete(songremove)
            PersistentStorage.shared.saveContext()
            
            do {
                try PersistentStorage.shared.saveContext()
            } catch {
                print("Couldn't save")
                
            }
            self.data.remove(at: indexPath.row)
            self.songs.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            if songs.count == 0{
                self.emptyViewFunc()
            }
            table.reloadData()
            
        }
        
    }
    
    var playlist = [Playlist]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.convertMusicTOData()
        
        self.playlist = PersistentStorage.shared.playlists()
        
        self.table.reloadData()

    }


    
    
    
    
}


//MARK: UITableViewDelegate

