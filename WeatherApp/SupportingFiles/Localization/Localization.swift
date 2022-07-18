import Foundation

enum LanguageString: String {
    case low
    case high
    case wind
    
    var localized: String {
        return localize()
    }
}

private extension LanguageString {
    static let errorCopy: String = "**ERROR*COPY**"
    
    static let sourceNotFound = "sourceNotFound"
    
    func localize() -> String {
        let copy = getCopy(tryPrefered: true)
        guard copy != LanguageString.errorCopy else {
            let copy = getCopy(tryPrefered: false)
            guard copy != LanguageString.errorCopy else {
                showErrorNoCopy(for: self)
                return ""
            }
            return copy
        }
        guard !copy.isEmpty else {
            showErrorEmpty(for: self)
            return ""
        }
        return copy
    }
    
    func getCopy(tryPrefered: Bool) -> String {
        let bundle = Bundle.main
        let copy = NSLocalizedString(self.rawValue,
                                     tableName: "Localizable",
                                     bundle: bundle,
                                     value: LanguageString.errorCopy,
                                     comment: "")
        return copy
    }
    
    func showErrorNoCopy(for key: LanguageString) {
        let lang: String = Locale.preferredLanguages.first ?? "?"
        print("Language: Key '\(key.rawValue)' not found for \(lang) language code...")
    }
    
    func showErrorEmpty(for key: LanguageString) {
        print("Language: Key '\(key.rawValue)' found, but its copy is empty...")
    }
}
