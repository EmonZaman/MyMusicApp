//
//  MusicData+CoreDataProperties.swift
//  MyMusic
//
//  Created by Twinbit Limited on 27/11/22.
//
//

import Foundation
import CoreData


extension MusicData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicData> {
        return NSFetchRequest<MusicData>(entityName: "MusicData")
    }

    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var songUrl: String?
    @NSManaged public var playlist: Playlist?

}

extension MusicData : Identifiable {

}
