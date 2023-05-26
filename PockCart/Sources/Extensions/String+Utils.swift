//
//  String+Utils.swift
//  pock-cart-courseu
//
//  Created by vivien bernard on 24/05/2023.
//

import Foundation

// MARK: - Date

extension String {
    func convertToDate(format: String) -> Date {
        guard let date = convertToDateOrNil(format: format) else {
            return Date()
        }
        return date
    }

    func convertToDateOrNil(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }

    func convertToApiDate() -> Date? {
        if let dateApi = self.convertToDateOrNil(format: DateFormat.dateApiFormat) {
            return dateApi
        } else if let dateApiLabel = self.convertToDateOrNil(format:DateFormat.dateLabelApiFormat) {
            return dateApiLabel
        }
        return nil
    }
}
