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

func doShuffle(data: WordData, selectedWord: inout Word, selectedNum: inout Int, beforeNum: inout Int, beforeListNum: inout Int, selectedListNum: inout Int, isShowAlert: inout Bool) {
    data.load()
    let trueIndices = data.lists.enumerated().compactMap { (index, dotList) -> Int? in
        if dotList.isshow {
            if dotList.dotlists.count != 0 {
                return index
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    //    if trueIndices.count > 0 {
    //        if trueIndices.count > 1 {
    //            while selectedListNum == beforeListNum {
    //                selectedListNum = trueIndices[Int.random(in: 0...(trueIndices.count-1))]
    //            }
    //            beforeListNum = selectedListNum
    //        } else {
    //            selectedListNum = trueIndices[0]
    //        }
    //
    //        if data.lists[selectedListNum].dotlists.count > 1 {
    //            while selectedNum == beforeNum {
    //                selectedNum = Int.random(in: 0...(data.lists[selectedListNum].dotlists.count-1))
    //            }
    //            beforeNum = selectedNum
    //            selectedWord = data.lists[selectedListNum].dotlists[selectedNum]
    //        } else if trueIndices.count == 1 {
    //            // 表示するリストが一つかつそのリストのワード数が一個のとき
    //            isShowAlert.toggle()
    //        } else {
    //            selectedWord = data.lists[selectedListNum].dotlists[0]
    //        }
    //
    //    } else {
    //        isShowAlert.toggle()
    //    }
    
    // isShowがtrueのリストのワードの数の合計値を計算
    var shuffleItemsSize: Int = 0
    trueIndices.forEach { shuffleItem in
        shuffleItemsSize += data.lists[shuffleItem].dotlists.count
    }
    
    var randomIndex: Int = Int.random(in: 0...shuffleItemsSize - 1)
    while randomIndex == selectedNum {
        randomIndex = Int.random(in: 0...shuffleItemsSize - 1)
    }
    selectedNum = randomIndex
    
    for shuffleItem in trueIndices {
        print("shuffleItem", shuffleItem)
        if randomIndex >= data.lists[shuffleItem].dotlists.count {
            randomIndex -= data.lists[shuffleItem].dotlists.count
        } else {
            selectedListNum = shuffleItem
            break
        }
    }
    selectedWord = data.lists[selectedListNum].dotlists[randomIndex]
    
}

func doShuffleTwo(data: WordData, shuffleData: inout ShuffleData) {
    print("doShuffleTwo!!")
    print("trueIndices:" , shuffleData.trueIndices)
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
