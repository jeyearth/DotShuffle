//
//  DataStore.swift
//  PowerWordTwo
//
//  Created by 平野慈英 on 2024/02/08.
//

import Foundation

class DataStore: ObservableObject {
    @Published var worddata: WordData = WordData()
    
    private func getWordsFileURL() throws -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("words.data")
    }
    
    func load() {
        do {
            let fileURL = try getWordsFileURL()
            let data = try Data(contentsOf: fileURL)
            worddata.words = try JSONDecoder().decode([Word].self, from: data)
            print("Words loaded: \(worddata.words.count)")
        } catch {
            print("Failed to load from file. Backup data used")
        }
    }
    
    func save() {
        do {
            let fileURL = try getWordsFileURL()
            let data = try JSONEncoder().encode(worddata.words)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("Words saved")
        } catch {
            print("Unable to save")
        }
    }
}
