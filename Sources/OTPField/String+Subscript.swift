
import Foundation

extension String {
    subscript(_ i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
