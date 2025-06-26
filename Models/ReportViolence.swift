//
//  ReportViolence.swift
//  TihiHeroj
//
//  Created by Djordje Mitrovic on 26.2.25..
//

import Foundation
import FirebaseFirestore

struct Attachment: Codable {
    let type: String // "photo", "video", "document"
    let url: String
}

struct ReportViolence: Identifiable, Codable {
    let id = UUID().uuidString // Unique ID for Firebase
    var anonymous: Bool
    var name: String
    var surname: String
    var email: String
    var mobilePhoneNumber: String
    var reportedPersonName: String = "" // Add this
    var relationship: String = ""      // Add t
    var frequency: String? = nil
    var numberOfRepetitionOfViolence: String // "once", "severalTime", "often"
    var publishedTimestamp: TimeInterval
    var city: String
    var place: String
    var perpetrator: String
    var extraInfoAboutPerpetrator: String
    var existAdditionalPerpetrators: Bool
    var victim: String
    var extraInfoAboutVictim: String
    var existAdditionalVictims: Bool
    var kindOfViolence: [String]
    var customKindOfViolence: String
    var description: String
    var attachments: [Attachment]
    var alreadyReported: Bool
    var whomReported: [String]
    var extraInfoOfReport: String
    var wantToReceiveNotification: Bool
    var emailToReceiveNotification: String
    var mobilePhoneNumberToReceiveNotification: String
    var status: String

    init() {
        anonymous = false
        name = ""
        surname = ""
        email = ""
        mobilePhoneNumber = ""
        numberOfRepetitionOfViolence = "once"
        publishedTimestamp = Date().timeIntervalSince1970
        city = ""
        place = ""
        perpetrator = "adult"
        extraInfoAboutPerpetrator = ""
        existAdditionalPerpetrators = false
        victim = "adult"
        extraInfoAboutVictim = ""
        existAdditionalVictims = false
        kindOfViolence = []
        customKindOfViolence = ""
        description = ""
        attachments = []
        alreadyReported = false
        whomReported = []
        extraInfoOfReport = ""
        wantToReceiveNotification = false
        emailToReceiveNotification = ""
        mobilePhoneNumberToReceiveNotification = ""
        status = "inProcessing"
    }
}
