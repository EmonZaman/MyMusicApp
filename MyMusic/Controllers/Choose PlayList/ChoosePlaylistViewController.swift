//
//  ChoosePlaylistViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 5/12/22.
//

import UIKit
protocol duplicateSongCheck: AnyObject {
    func pass(check: Int)
    
    
}

class ChoosePlaylistViewController: UIViewController {
    
    @IBOutlet weak var choosePlayListTableView: UITableView!
    var playListArray = [String]()
    var song: MusicData?
    var nameeeee: String?
    let context = PersistentStorage.shared.context
    weak var delegate2: duplicateSongCheck?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        allPlayList()
        choosePlayListTableView.delegate = self
        choosePlayListTableView.dataSource = self
        
        
    }
    func allPlayList(){
        playListArray.removeAll()
        
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

extension ChoosePlaylistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        do {
            
            guard let result1 =   try PersistentStorage.shared.context.fetch(Playlist.fetchRequest()) as? [Playlist] else {return}
            
            var localCheck = 0
            result1.forEach { playlist in
                
//                print("in")
//                print(playlist)
//                print(song)
//                print("song name")
//                print(song?.name)
//                if playlist.name == playListArray[indexPath.row]{
//                    print(playlist.name)
//                    print("This is matched")
//                                        playlist.songs?.forEach({ song1 in
//                                            print("SONG LIST")
//                                            var song1 = song1 as! MusicData
//                                            print(song1.name)
//                                            print(song1.image)
//                                            if(song1.name == self.song?.name)
//                                            {
//                                                print(song1.name)
//                                                print(self.song?.name)
//
//
//                                                print("THIS IS ALREADY IN your playsliu")
////                                                if let delegate2 = self.delegate2{
////                                                    delegate2.pass(check: 1)
////                                                    localCheck = 0
////                                                }
//
//
//                                            }
//
//
//                                        })
//
//                }
                
                if playlist.name == playListArray[indexPath.row]{
                    print("playlist Name")
                    print(playlist.name)


                    print("TOTAL SONG COUNT AGAINS PLAYLSIT")
                    print(playlist.songs?.count)
                    //  print(playlist.songs)

                    playlist.songs?.forEach({ song1 in
                        print("SONG LIST")
                        var song1 = song1 as! MusicData
                        print(song1.name)
                        print(song1.image)
                        if(song1.name == self.song?.name)
                        {
                            print(song1.name)
                            print(self.song?.name)


                            print("THIS IS ALREADY IN your playsliu")
                            if let delegate2 = self.delegate2{
                                self.dismiss(animated: true) {
                                    delegate2.pass(check: 1)
                                }

                                localCheck = 1
                                return
                            }


                        }


                    })
                    if localCheck == 0 {

                        if let delegate2 = self.delegate2{
                            delegate2.pass(check: 0)

                        }
                        playlist.addToSongs(self.song!)
                        PersistentStorage.shared.saveContext()
                        self.dismiss(animated: true)
                        
                       return

                    }


                }
                
                
            }
            
            
        }
        catch let error {
            debugPrint(error)
        }
    }
    
    
}
extension ChoosePlaylistViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = choosePlayListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChoosePlayListTableViewCell
        cell.playListNameToChoose.text = playListArray[indexPath.row]
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70    }
    
}


