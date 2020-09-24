
import UIKit

struct Card: Hashable {
    let name: String
    
    var image: UIImage {
        return UIImage(named: name)!
    }
}
