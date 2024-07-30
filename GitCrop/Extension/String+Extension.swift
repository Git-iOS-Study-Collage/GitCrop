//
//  String+Extension.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import Foundation

extension String {
    func localTitleConfirm() -> String {
        let text: String
        switch self {
        case "Selfies":
           text = "셀카"
        case "Favorites":
            text = "즐겨찾는 항목"
        case "Recents":
            text = "최근 항목"
        case "Screenshots":
            text = "스크린샷"
        case "Panoramas":
            text = "파노라마"
        default:
            text = self
        }
        return text
    }
}
