//
//  FrequencyOption.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 21.3.25..
//

import Foundation

enum FrequencyOption: String, CaseIterable, Codable {
    case once
    case severalTime
    case often
    
    var displayText: String {
        switch self {
        case .once: return "Једном"
        case .severalTime: return "Неколико пута"
        case .often: return "Често се дешава"
        }
    }
}

enum LocationOption: String, CaseIterable, Codable {
    case institutionOfEducation
    case online
    case home
    case policePlace
    case otherInstitution
    
    var displayText: String {
        switch self {
        case .institutionOfEducation: return "У установи образовања"
        case .online: return "На интернету"
        case .home: return "Код куће"
        case .policePlace: return "На улици / јавном месту"
        case .otherInstitution: return "У другој установи"
        }
    }
}

enum PerpetratorOption: String, CaseIterable, Codable {
    case kid
    case adult
    case unknown
    
    var displayText: String {
        switch self {
        case .kid: return "Дете"
        case .adult: return "Одрасло лице"
        case .unknown: return "Непознато"
        }
    }
}

enum VictimOption: String, CaseIterable, Codable {
    case kid
    case adult
    case unknown
    
    var displayText: String {
        switch self {
        case .kid: return "Дете"
        case .adult: return "Одрасло лице"
        case .unknown: return "Непознато"
        }
    }
}

enum YesNoOption: String, CaseIterable {
    case yes = "Да"
    case no = "Не"
    
    var displayText: String { rawValue }
    var value: Bool { self == .yes }
}
