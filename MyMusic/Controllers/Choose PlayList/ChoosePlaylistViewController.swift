//
//  ChoosePlaylistViewController.swift
//  MyMusic
//
//  Created by Twinbit Limited on 5/12/22.
//

import UIKit

class ChoosePlaylistViewController: UIViewController {
    
    @IBOutlet weak var choosePlayListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        choosePlayListTableView.delegate = self
        choosePlayListTableView.dataSource = self

        
    }
   
    
    


   

}

extension ChoosePlaylistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you just tapped")
        
    }
    
}
extension ChoosePlaylistViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = choosePlayListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChoosePlayListTableViewCell
        cell.playListNameToChoose.text = "PLay List"
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70    }
        
}


