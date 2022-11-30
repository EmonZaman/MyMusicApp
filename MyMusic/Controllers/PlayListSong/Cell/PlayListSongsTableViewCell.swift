//
//  PlayListSongsTableViewCell.swift
//  MyMusic
//
//  Created by Twinbit Limited on 27/11/22.
//

import UIKit

class PlayListSongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPlayListSongName: UILabel!
    
    @IBOutlet weak var lblPlayListSongDetails: UILabel!
    
    @IBOutlet weak var mImgPlayListVIew: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
