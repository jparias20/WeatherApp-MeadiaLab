import Foundation

final class JSONHelper {
    
    static func loadJson<T: Decodable>(fileName: String) -> T {
        let bundle = Bundle(for: JSONHelper.self)
        guard let filelocation = bundle.url(forResource: fileName, withExtension: "json") else { fatalError("No json loaded") }
        
        do {
            let data = try Data(contentsOf: filelocation)
            let jsonDecoder = JSONDecoder()
            let obj = try jsonDecoder.decode(T.self, from: data)
            
            return obj
        } catch {
            fatalError("loading JSON: \(error.localizedDescription)")
        }
    }
}
