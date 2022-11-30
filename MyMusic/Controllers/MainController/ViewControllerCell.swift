//
//  ViewControllerCell.swift
//  MyMusic
//
//  Created by Twinbit Limited on 16/11/22.
//

import UIKit

var playListArray = [String]()
class ViewControllerCell: UITableViewCell {
    func sendData(name: String, albumName: String, artistname: String, image: String, trackName: String, thumbImgae: String) {
        print("none")
    }
    
    
    var song: MusicData?
    let context = PersistentStorage.shared.context
    
    
    @IBOutlet weak var lblSongName: UILabel!
    
    @IBOutlet weak var lblSongDetails: UILabel!
    
    @IBOutlet weak var mImgVIew: UIImageView!
    
    @IBOutlet weak var playlistPopUpButton: UIButton! {
        
        didSet{
            allPlayList()
           let ans =  setPopUpButton()
            
          
            print("POP UP BUTTON CHOOSE")
           // print(ans)
        }
    }
    
    
//    var folder = [Playlist](){
//        didSet{
//            allPlayList()
//           let ans =  setPopUpButton()
//        }
//    }
    var playListArray = [String]()
    func setPopUpButton(){
      
        let optionClosure = {(action: UIAction) in
            print("ACTIONSSS")
            print(action.title)
            var name: String?
            
            if action.title != "none" {
                let newData = MusicData(context: self.context)
                if let song = self.song {
                    print(song)
                    newData.name = song.name!
                    newData.image = song.image ?? "1"
                    newData.songUrl = song.songUrl!
                    newData.albumName = song.albumName ?? " "
                    newData.artistName = song.artistName ?? " "
                    newData.id = song.id
                    PersistentStorage.shared.saveContext()
                
                }
                print("New Data")
                print(newData)
                print("done")
                do {

                    guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
        
            
                    result.forEach { playlist in
                        print("in")
                        if playlist.name == action.title{
                            print("playlist Name")
                            print(playlist.name)
                            playlist.addToSongs(newData)
                            PersistentStorage.shared.saveContext()
                            return
                        }
                        
                        
                    }
                    
                    
                } catch let error {
                    debugPrint(error)
                }
                
            }
            
                }

        // create an array to store the actions
        var optionsArray = [UIAction]()
        var action = UIAction(title: "none", state: .off, handler: optionClosure)
        optionsArray.append(action)

        // loop and populate the actions array
        for listss in playListArray{
            // create each action and insert the right country as a title
             action = UIAction(title: listss, state: .off, handler: optionClosure)
                    
            // add newly created action to actions array
            optionsArray.append(action)
        }
                
                
        // set the state of first country in the array as ON
      //  optionsArray[0].state = .on

        // create an options menu
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
                
        // add everything to your button
        playlistPopUpButton.menu = optionsMenu

        // make sure the popup button shows the selected value
        if #available(iOS 15.0, *) {
            playlistPopUpButton.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
        playlistPopUpButton.showsMenuAsPrimaryAction = true
//        self.playlistPopUpButton.menu = UIMenu(children: [
//
//
//
//                    UIAction(title: playListArray[0], handler: options),
//                    UIAction(title: playListArray[1], handler: options),
//                    UIAction(title: "name", handler: options),
//                    UIAction(title: "name", handler: options),
//
//
//            ])
//            self.playlistPopUpButton.showsMenuAsPrimaryAction = true
//            if #available(iOS 15.0, *) {
//                self.playlistPopUpButton.changesSelectionAsPrimaryAction = true
//            } else {
//                // Fallback on earlier versions
//            }
        
        print("OPTIONS CHoosing")
      //  print(options)
            
        
    }
    func allPlayList(){
        
//        for itm in folder{
//            playListArray.append(itm.name!)
//        }
        do {

            guard let result =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
            print("data Converting start ",result.count)

            result.forEach { playlist in
                print(playlist.name)
                self.playListArray.append(playlist.name ?? " ")


            }


        } catch let error {
            debugPrint(error)
        }
        
    }
    

    
    
    


    
    

  

}
