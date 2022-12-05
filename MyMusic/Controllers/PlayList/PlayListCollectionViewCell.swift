//
//  PlayListCollectionViewCell.swift
//  MyMusic
//
//  Created by Twinbit Limited on 24/11/22.
//

import UIKit

class PlayListCollectionViewCell: UICollectionViewCell {
    
    var playList: Playlist?
    let context = PersistentStorage.shared.context
    
    weak var delegate: PlayListDelegate?
  
    @IBOutlet weak var playListName: UILabel!
    
    @IBOutlet weak var lastImage: UIImageView!
    
    @IBOutlet weak var playListDelete: UIButton! {
        
        didSet{
            
           setPopUpButton()
          
            print("POP UP BUTTON CHOOSE")
           // print(ans)
        }
    }
    func setPopUpButton(){
      
        let optionClosure = {(action: UIAction) in
            print("ACTIONSSS")
            print(action.title)
            

            if action.title == "Delete"{
                
                PersistentStorage.shared.deletePlayList(playlist: self.playList!)
                PersistentStorage.shared.saveContext()
                if let delegate = self.delegate {
                    delegate.deletePlayList()
                }
            
                
            }                }

        // create an array to store the actions
        var optionsArray = [UIAction]()
        var action = UIAction(title: "Delete", state: .off, handler: optionClosure)
        var action1 = UIAction(title: "Cancel", state: .off, handler: optionClosure)
        optionsArray.append(action)
        optionsArray.append(action1)

        // loop and populate the actions array
       
                
                
        // set the state of first country in the array as ON
      //  optionsArray[0].state = .on

        // create an options menu
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
                
        // add everything to your button
        playListDelete.menu = optionsMenu

        // make sure the popup button shows the selected value
        if #available(iOS 15.0, *) {
           // playListDelete.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
     //   playListDelete.showsMenuAsPrimaryAction = true
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
}
