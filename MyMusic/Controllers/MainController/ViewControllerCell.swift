//
//  ViewControllerCell1.swift
//  MyMusic
//
//  Created by Twinbit Limited on 1/12/22.
//

import UIKit
//
//  ViewControllerCell.swift
//  MyMusic
//
//  Created by Twinbit Limited on 16/11/22.
//

import UIKit
//protocol duplicateSongCheck: AnyObject {
//    func pass(check: Int)
//
//
//}

protocol CellSubclassDelegate: AnyObject {
    func buttonTapped(cell: ViewControllerCell, song: MusicData)
}

//var playListArray = [String]()



class ViewControllerCell: UITableViewCell {
  
    
    
    func sendData(name: String, albumName: String, artistname: String, image: String, trackName: String, thumbImgae: String) {
        print("none")
    }
    
  //  var delegate2 = duplicateSongCheck.self
  //  weak var delegate2: duplicateSongCheck?
    weak var delegate3:CellSubclassDelegate?
    var song: MusicData?
    let context = PersistentStorage.shared.context
    
     
    
    @IBOutlet weak var lblSongName: UILabel!
    
    @IBOutlet weak var lblSongDetails: UILabel!
    
    @IBOutlet weak var mImgVIew: UIImageView!
    @IBAction func someButtonTapped(_ sender: UIButton) {
        
           print("button is working")
        
        print(song)
        self.delegate3?.buttonTapped(cell: self, song: song!)
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate3 = nil
    }

        
    
//    @IBOutlet weak var playlistPopUpButton: UIButton! {
//        
//        didSet{
//            
//            //Button Action
//            playlistPopUpButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//          
//            print("POP UP BUTTON CHOOSE")
//           // print(ans)
//        }
//    }
//    
//    
////    var folder = [Playlist](){
////        didSet{
////            allPlayList()
////           let ans =  setPopUpButton()
////        }
////    }
//    var playListArray = [String]()
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    @objc func buttonAction() {
////        PersistentStorage.shared.saveContext()
////        print("Button is called")
////        allPlayList()
////        PersistentStorage.shared.saveContext()
////        setPopUpButton()
//        func buttonClickAtIndex(index: Int) {
//            
//        }
//        
//        
//    }
//    
//    
//    func setPopUpButton(){
//      
//        let optionClosure = {(action: UIAction) in
//            print("ACTIONSSS")
//            print(action.title)
//            var name: String?
//            
//            if action.title != "none" {
//               // let newData = MusicData(context: self.context)
////                if let song = self.song {
////                    print(song)
////                    newData.name = song.name!
////                    newData.image = song.image ?? "1"
////                    newData.songUrl = song.songUrl!
////                    newData.albumName = song.albumName ?? " "
////                    newData.artistName = song.artistName ?? " "
////                    newData.id = song.id
////                    PersistentStorage.shared.saveContext()
////
////                }
//                print("New Data")
//              //  print(newData)
//                print("done")
//                do {
//
//                    guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
//        
//                    var localCheck = 0
//                    result.forEach { playlist in
//                        print("in")
//                        if playlist.name == action.title{
//                            print("playlist Name")
//                            print(playlist.name)
//                            
//                         
//                            print("TOTAL SONG COUNT AGAINS PLAYLSIT")
//                            print(playlist.songs?.count)
//                          //  print(playlist.songs)
//                           
//                            playlist.songs?.forEach({ song1 in
//                                print("SONG LIST")
//                               var song1 = song1 as! MusicData
//                                print(song1.name)
//                                print(song1.image)
//                                if(song1.name == self.song?.name)
//                                {
//                                    print(song1.name)
//                                    print(self.song?.name)
////                                    let alertController = UIAlertController(title: "Alert", message: "There is a Playlist with same name already exists in your app Choose Another", preferredStyle: .alert)
////
////                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////                                    alertController.addAction(okAction)
////
////                                  //  self.present(alertController, animated: true)
//                                    
//                                    print("THIS IS ALREADY IN your playsliu")
//                                    if let delegate2 = self.delegate2{
//                                        delegate2.pass(check: 1)
//                                        localCheck = 0
//                                    }
//                                    
//                                    
//                                }
//                                
//                                
//                            })
//                            if localCheck == 0 {
//                              
//                                    if let delegate2 = self.delegate2{
//                                        delegate2.pass(check: 0)
//                                    
//                                    }
//                                playlist.addToSongs(self.song!)
//                                PersistentStorage.shared.saveContext()
//                                return
//                                
//                            }
//                            
//                           
//                        }
//                        
//                        
//                    }
//                    
//                    
//                } catch let error {
//                    debugPrint(error)
//                }
//                
//            }
//            
//                }
//
//        // create an array to store the actions
//        var optionsArray = [UIAction]()
//        var action = UIAction(title: "none", state: .off, handler: optionClosure)
//        optionsArray.append(action)
//
//        // loop and populate the actions array
//        for listss in playListArray{
//            // create each action and insert the right country as a title
//             action = UIAction(title: listss, state: .off, handler: optionClosure)
//                    
//            // add newly created action to actions array
//            optionsArray.append(action)
//        }
//                
//                
//        // set the state of first country in the array as ON
//      //  optionsArray[0].state = .on
//
//        // create an options menu
//        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
//                
//        // add everything to your button
//        playlistPopUpButton.menu = optionsMenu
//
//        // make sure the popup button shows the selected value
//        if #available(iOS 15.0, *) {
//            playlistPopUpButton.changesSelectionAsPrimaryAction = true
//        } else {
//            // Fallback on earlier versions
//        }
//        playlistPopUpButton.showsMenuAsPrimaryAction = true
////        self.playlistPopUpButton.menu = UIMenu(children: [
////
////
////
////                    UIAction(title: playListArray[0], handler: options),
////                    UIAction(title: playListArray[1], handler: options),
////                    UIAction(title: "name", handler: options),
////                    UIAction(title: "name", handler: options),
////
////
////            ])
////            self.playlistPopUpButton.showsMenuAsPrimaryAction = true
////            if #available(iOS 15.0, *) {
////                self.playlistPopUpButton.changesSelectionAsPrimaryAction = true
////            } else {
////                // Fallback on earlier versions
////            }
//        
//        print("OPTIONS CHoosing")
//      //  print(options)
//            
//        
//    }
//    func allPlayList(){
//        playListArray.removeAll()
//        
////        for itm in folder{
////            playListArray.append(itm.name!)
////        }
//        do {
//
//            guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
//            print("data Converting start ",result.count)
//
//            result.forEach { playlist in
//                print(playlist.name)
//                self.playListArray.append(playlist.name ?? " ")
//
//
//            }
//
//
//        } catch let error {
//            debugPrint(error)
//        }
//        
//    }
//    
//
//    
//    
//    


    
    

  

}
