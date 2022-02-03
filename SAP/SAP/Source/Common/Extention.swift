//
//  Extention.swift
//  SAP
//
//  Created by Hamza Ahmed on 01/02/2022.
//

import Foundation

extension UserDefaults {
    
    func saveHistory(_ historyArr: [History]) {
        let data = historyArr.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: Constant.historyArrayKey)
    }
    
    func loadHistory() -> [History] {
        guard let encodedData = UserDefaults.standard.array(forKey: Constant.historyArrayKey) as? [Data] else {
            return []
        }
        return encodedData.map { try! JSONDecoder().decode(History.self, from: $0) }
    }
}
