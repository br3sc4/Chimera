//
//  LocaleModel.swift
//  Chimera
//
//  Created by Nicola Rigoni on 19/01/23.
//

import Foundation

struct LocaleModel: Identifiable, Hashable {
    var id: String {
        countryCode
    }
    let countryCode: String
    let countryName: String
}
