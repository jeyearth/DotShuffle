//
//  WordData.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

struct Word: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = ""
}

struct DotList: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String = ""
    var dotlists:[Word] = []
    
    init(name: String, dotlists: [Word]) {
        self.name = name
        self.dotlists = dotlists
    }
}

final class WordData: ObservableObject {
    @Published var words: [Word] = [
        Word(text: "Connecting the Dots"),
        Word(text: "Stay hungry, Stay foolish"),
        Word(text: "If today were the last day of my life, would I want to do what I am about to do today?"),
    ]
    
    @Published var lists: [DotList] = [
        DotList(name: "Inbox", dotlists:
                    [
                        Word(text: "Connecting the Dots"),
                        Word(text: "Stay hungry, Stay foolish"),
                        Word(text: "If today were the last day of my life, would I want to do what I am about to do today?"),
                    ]
               ),
    ]
    
    func add(_ word: Word) {
//        words.append(word)
        lists[0].dotlists.append(word)
        
    }
    
    func remove(_ word: Word) {
//        words.removeAll { $0.id == word.id}
        lists[0].dotlists.removeAll { $0.id == word.id}
    }
    
    func addList(_ dotlist: DotList) {
        lists.append(dotlist)
    }
    
    func removeList(_ dotlist: DotList) {
        lists.removeAll { $0.id == dotlist.id}
    }
    
    private static func getWordsFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("words.data")
    }
    
    private static func getListsFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("lists.data")
    }
    
    func load() {
        do {
            let fileURL = try WordData.getWordsFileURL()
            let data = try Data(contentsOf: fileURL)
            words = try JSONDecoder().decode([Word].self, from: data)
            print("Words loaded: \(words.count)")
        } catch {
            print("Failed to load from file. Backup data used")
        }
        
        // load lists
        do {
            let fileURL = try WordData.getListsFileURL()
            let data = try Data(contentsOf: fileURL)
            lists = try JSONDecoder().decode([DotList].self, from: data)
            print("Lists loaded: \(lists.count)")
        } catch {
            print("Failed to loadLists()")
        }

    }
    
    func loadLists() {
        do {
            let fileURL = try WordData.getListsFileURL()
            let data = try Data(contentsOf: fileURL)
            lists = try JSONDecoder().decode([DotList].self, from: data)
            print("Lists loaded: \(lists.count)")
        } catch {
            print("Failed to loadLists()")
        }
    }
    
    func save() {
        do {
            let fileURL = try WordData.getWordsFileURL()
            let data = try JSONEncoder().encode(words)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Words saved")
        } catch {
            print("Unable to save")
        }
        
        // save lists
        do {
            let fileURL = try WordData.getListsFileURL()
            let data = try JSONEncoder().encode(lists)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Lists saved")
        } catch {
            print("Unable to save Lists")
        }
    }
    
    func saveLists() {
        do {
            let fileURL = try WordData.getListsFileURL()
            let data = try JSONEncoder().encode(lists)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Lists saved")
        } catch {
            print("Unable to save Lists")
        }
    }
    
    //元のデータ構造（wordsのみ）から新しいデータ構造（lists管理）へ対応するための関数
    func wordsToLists() {
        self.load()
        
        if words.count != 0 {
            print("do change")
            do {
                let fileURL = try WordData.getWordsFileURL()
                let data = try Data(contentsOf: fileURL)
                words = try JSONDecoder().decode([Word].self, from: data)
                
                lists[0].dotlists = words
                
                self.saveLists()
                
                //print(data.lists[0].dotlists[1].text)
                words.removeAll()
                self.save()
                self.loadLists()
                print("listsだよ！")
                print(lists)
                print("words to lists change succes")
            } catch {
                print("failed to change")
            } // do catch ここまで
        } else {
            print("don't change")
        }// if ここまで
    }
}

enum LaunchStatus {
    case FirstLaunch
    case NewVersionLaunch
    case Launched
}

class LaunchUtil {
    static let launchedVersionKey = "launchedVersion"
    @AppStorage(launchedVersionKey) static var launchedVersion = ""
    
    static var launchStatus: LaunchStatus {
        get{
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            let launchedVersion = self.launchedVersion
            
            self.launchedVersion = version
            
            if launchedVersion == "" {
                return .FirstLaunch
            }
            
            return version == launchedVersion ? .Launched : .NewVersionLaunch
        }
    }
}
