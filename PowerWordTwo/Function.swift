//
//  Function.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/17.
//
import SwiftUI

struct ShuffleData {
    var selectedWord: Word = Word()
    var trueIndices: [Int] = []
    var shuffleItemsCount: Int = 0
    var beforeRandomIndex: Int = 0
    var selectedListIndex: Int = 0
    var isShowAlert: Bool = false
    
    init() {
        selectedWord = Word()
        trueIndices = []
        shuffleItemsCount = 0
        beforeRandomIndex = 0
        selectedListIndex = 0
        isShowAlert = false
    }
    
    init(data: WordData) {
        data.load()
        trueIndices = data.lists.enumerated().compactMap { (index, dotList) -> Int? in
            if dotList.isshow {
                return index
            } else {
                return nil
            }
        }
        print("trueIndices:" ,trueIndices)
        shuffleItemsCount = trueIndices.reduce(0) { count, index in
            count + data.lists[index].dotlists.count
        }
    }
    
}

func doShuffle(data: WordData, shuffleData: inout ShuffleData) {
    if shuffleData.trueIndices.count > 0 {
        if shuffleData.shuffleItemsCount == 0 {
            shuffleData.isShowAlert.toggle()
        } else if shuffleData.shuffleItemsCount == 1 {
            shuffleData.selectedWord = data.lists[shuffleData.trueIndices[0]].dotlists[0]
            shuffleData.isShowAlert.toggle()
        } else {
            var randomIndex: Int = Int.random(in: 0...shuffleData.shuffleItemsCount - 1)
            while randomIndex == shuffleData.beforeRandomIndex {
                randomIndex = Int.random(in: 0...shuffleData.shuffleItemsCount - 1)
            }
            shuffleData.beforeRandomIndex = randomIndex
            
            for shuffleItem in shuffleData.trueIndices {
                if randomIndex >= data.lists[shuffleItem].dotlists.count {
                    randomIndex -= data.lists[shuffleItem].dotlists.count
                } else {
                    shuffleData.selectedListIndex = shuffleItem
                    break
                }
            }
            shuffleData.selectedWord = data.lists[shuffleData.selectedListIndex].dotlists[randomIndex]
        }
    } else {
        shuffleData.isShowAlert.toggle()
    }
}
