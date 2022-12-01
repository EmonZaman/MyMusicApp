//
//  PersistentStorage.swift
//  MyMusic
//
//  Created by Twinbit Limited on 20/11/22.
//

import Foundation
import CoreData

final class PersistentStorage
{

    private init(){}
    static let shared = PersistentStorage()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MyMusic")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    func saveContext() {
        //if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
       // }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
    {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            
            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
    
    func playlist(name: String) -> Playlist {
           let playlist = Playlist(context: persistentContainer.viewContext)
        playlist.name = name
        print("playlist add is calling")
        return playlist
       }
    
    func musicData(name: String, artist: String, songUrl: String, image: String, playlist: Playlist) -> MusicData {
        print("music add is caling..")
           let song = MusicData(context: persistentContainer.viewContext)
        song.name = name
        song.artistName = artist
        song.songUrl = songUrl
        song.image = image
        playlist.addToSongs(song)
      
           
        return song
       }
    
    func playlists() -> [Playlist] {
        print("playlist is syuccefully fetching")
          let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
          var fetchedPlaylists: [Playlist] = []
          
          do {
              fetchedPlaylists = try persistentContainer.viewContext.fetch(request)
          } catch let error {
              print("Error fetching singers \(error)")
          }
          return fetchedPlaylists
      }
    func songs(playlist: Playlist) -> [MusicData] {
        print("ALL SONGS is Called")
           let request: NSFetchRequest<MusicData> = MusicData.fetchRequest()

        request.predicate = NSPredicate(format: "name == %@", playlist.name!)
        //   request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
           var fetchedSongs: [MusicData] = []
        print(fetchedSongs)
           
           do {
               fetchedSongs = try persistentContainer.viewContext.fetch(request)
           } catch let error {
               print("Error fetching songs \(error)")
           }
        print(fetchedSongs)
        print("succesfully returnning")
           return fetchedSongs
       }
    func deleteSong(song: MusicData) {
           let context = persistentContainer.viewContext
           context.delete(song)
           saveContext()
       }
       
       func deletePlayList(playlist: Playlist) {
           let context = persistentContainer.viewContext
           context.delete(playlist)
           saveContext()
           
           
       }
    
    
}
