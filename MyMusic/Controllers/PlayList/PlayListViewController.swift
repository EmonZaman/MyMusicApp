//
//  PlayListViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 24/11/22.
//

import UIKit

class PlayListViewController: UIViewController {
    @IBOutlet weak var playListView: UICollectionView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Playlist"
        navigationController?.navigationBar.prefersLargeTitles = true

        print("Playlist view controller callled")
        let layout = UICollectionViewFlowLayout()
        
        //layout.itemSize = CGSize(width: 120, height: 120)
        playListView.collectionViewLayout = layout
        playListView.delegate = self
        playListView.dataSource = self
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
          }))
        self.present(alert, animated: true, completion: {
              print("completion block")
          })
        
    }

    

}
extension PlayListViewController: UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("This is tapped")
//        print(albumList[indexPath.row])
//        if let vc = storyboard?.instantiateViewController(identifier: "MusicListViewController") as? MusicListViewController{
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
}
extension PlayListViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playListView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayListCollectionViewCell
        cell.playListName.text = "TTT"
        cell.playListName.backgroundColor = .red
       
        
        return cell
    }
    
    
    
}
