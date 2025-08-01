import SwiftUI

class ReportViewModel: ObservableObject {
    @Published var report = ReportViolence()
    private let fireStoreManager: FireStoreManager
    
    init(fireStoreManager: FireStoreManager = FireStoreManager()) {
        self.fireStoreManager = fireStoreManager
    }
    
    func saveToFirebase() {
        fireStoreManager.saveReport(report) { error in
            if let error = error {
                print("Error saving report to Firebase: \(error.localizedDescription)")
            }
        }
    }
    
    func isReport1FormValid(selection: Bool, firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
        if selection {
            return true
        } else {
            return !firstName.isEmpty &&
                   !lastName.isEmpty &&
                   !email.isEmpty &&
                   !phoneNumber.isEmpty
        }
    }
    
    func saveReport1Data(selection: Bool, firstName: String, lastName: String, email: String, phoneNumber: String) {
        report.anonymous = selection
        report.name = firstName.isEmpty ? "" : firstName
        report.surname = lastName.isEmpty ? "" : lastName
        report.email = email.isEmpty ? "" : email
        report.mobilePhoneNumber = formatPhoneNumber(phoneNumber.isEmpty ? "" : phoneNumber)
    }
    
    func isReport2FormValid(personName: String, relationship: String, frequency: String?) -> Bool {
        return !personName.isEmpty && !relationship.isEmpty && frequency != nil
    }
    
    func saveReport2Data(personName: String, relationship: String, frequency: String?) {
        report.reportedPersonName = personName
        report.relationship = relationship
        report.frequency = frequency
    }
    
    public func formatPhoneNumber(_ number: String) -> String {
        var cleanedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if cleanedNumber.hasPrefix("0") && cleanedNumber.count > 1 {
            cleanedNumber = "+381" + String(cleanedNumber.dropFirst())
        } else if !cleanedNumber.hasPrefix("+381") && cleanedNumber.count == 9 {
            cleanedNumber = "+381" + cleanedNumber
        }
        return cleanedNumber
    }
}
