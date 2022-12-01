//
//  MusicData+CoreDataProperties.swift
//  MyMusic
//
//  Created by Twinbit Limited on 1/12/22.
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
    @NSManaged public var playlist: NSSet?

}

// MARK: Generated accessors for playlist
extension MusicData {

    @objc(addPlaylistObject:)
    @NSManaged public func addToPlaylist(_ value: Playlist)

    @objc(removePlaylistObject:)
    @NSManaged public func removeFromPlaylist(_ value: Playlist)

    @objc(addPlaylist:)
    @NSManaged public func addToPlaylist(_ values: NSSet)

    @objc(removePlaylist:)
    @NSManaged public func removeFromPlaylist(_ values: NSSet)

}

extension MusicData : Identifiable {

}
