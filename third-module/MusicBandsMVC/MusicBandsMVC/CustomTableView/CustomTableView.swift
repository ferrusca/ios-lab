//
//  CustomTableView.swift
//  MusicBandsMVC
//
//  Created by Jorge Ferrusca on 18/05/24.
//

import Foundation

struct CustomTableViewRow {
    let title: String
    let subtitle: String
    let imagePath: String
    let onRowClick: () -> Void;
}

struct Section {
    let rows: [CustomTableViewRow]
    let header: String
}
