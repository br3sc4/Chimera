//
//  NSLocale.swift
//  Chimera
//
//  Created by Nicola Rigoni on 19/01/23.
//

import Foundation


extension NSLocale {
    class func locales() -> [LocaleModel] {

        var locales: [LocaleModel] = []
        for localeCode in NSLocale.isoCountryCodes {
            let currentLocale = NSLocale.current as NSLocale
            let countryName = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            let countryCode = localeCode
            if let countryName {
                let locale = LocaleModel(countryCode: countryCode, countryName: countryName)
                locales.append(locale)
            }
        }
        return locales
    }
}
