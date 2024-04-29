//
//  WordData.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import SwiftUI

let kWordDataKey = "word_data"

struct Word: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String = ""
}

final class WordData: ObservableObject {
    @Published var words: [Word] = [
        Word(text: "Connecting the Dots"),
        Word(text: "Stay hungry, Stay foolish"),
        Word(text: "If today were the last day of my life, would I want to do what I am about to do today?"),
    ]
    
    func add(_ word: Word) {
        words.append(word)
    }
    
    func remove(_ word: Word) {
        words.removeAll { $0.id == word.id}
    }
    
    private static func getWordsFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("words.data")
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
