//
//  Function.swift
//  DotShuffle
//
//  Created by 平野慈英 on 2024/05/17.
//
import SwiftUI

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
    
    if trueIndices.count > 0 {
        if trueIndices.count > 1 {
            while selectedListNum == beforeListNum {
                selectedListNum = trueIndices[Int.random(in: 0...(trueIndices.count-1))]
            }
            beforeListNum = selectedListNum
        } else {
            selectedListNum = trueIndices[0]
        }
        
        if data.lists[selectedListNum].dotlists.count > 1 {
            while selectedNum == beforeNum {
                selectedNum = Int.random(in: 0...(data.lists[selectedListNum].dotlists.count-1))
            }
            beforeNum = selectedNum
            selectedWord = data.lists[selectedListNum].dotlists[selectedNum]
        } else if trueIndices.count == 1 {
            // 表示するリストが一つかつそのリストのワード数が一個のとき
            isShowAlert.toggle()
        } else {
            selectedWord = data.lists[selectedListNum].dotlists[0]
        }
        
    } else {
        isShowAlert.toggle()
    }
}
