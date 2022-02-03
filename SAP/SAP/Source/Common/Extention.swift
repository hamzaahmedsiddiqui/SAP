//
//  Extention.swift
//  SAP
//
//  Created by Hamza Ahmed on 01/02/2022.
//

import Foundation
import UIKit


// MARK: - UserDefaults
/**
 -Extension for UserDefaults for saving/loading search history
 -We can use another apporacch to save data like CoreData or SQLite but as data is too small thats why we used UserDefault to save the data.
 */
typealias AlertActionHandler = ((UIAlertAction) -> Void)

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
extension String {
    func alertAction(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}
extension UIAlertController.Style {
    func controller(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        return _controller
    }
}
