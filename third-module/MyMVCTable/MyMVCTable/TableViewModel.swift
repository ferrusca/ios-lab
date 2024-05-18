//
//  TableViewModel.swift
//  MyMVCTable
//
//  Created by Jorge Ferrusca on 17/05/24.
//

import Foundation

struct Row {
    var title: String
    var description: String
}


class TableViewModel {
    var data: [Row]
    
    init() {
        data = [
            Row(title: "Pikachu", description: "Electrico"),
            Row(title: "Charmander", description: "Fuego"),
            Row(title: "Gengar", description: "Fantasma")
        ]
    }
    
    func getCountArray() -> Int {
        data.count
    }
    
    func getTitle(_ index: IndexPath) -> String {
        data[index.row].title
    }
    
    func getDescription(_ index: IndexPath) -> String {
        data[index.row].description
    }
    
    func addElement(element: Row) -> Void {
        data.append(element)
    }
    
    func getSections() -> Int {
        3
    }
}
