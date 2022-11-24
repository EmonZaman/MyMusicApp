//
//  Playlist+CoreDataProperties.swift
//  MyMusic
//
//  Created by Twinbit Limited on 24/11/22.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var music: NSSet?

}

// MARK: Generated accessors for music
extension Playlist {

    @objc(addMusicObject:)
    @NSManaged public func addToMusic(_ value: MusicData)

    @objc(removeMusicObject:)
    @NSManaged public func removeFromMusic(_ value: MusicData)

    @objc(addMusic:)
    @NSManaged public func addToMusic(_ values: NSSet)

    @objc(removeMusic:)
    @NSManaged public func removeFromMusic(_ values: NSSet)

}

extension Playlist : Identifiable {

}
