import Foundation
import UIKit

@IBDesignable class SideBySideCardSuperView: UIView {
    
    @IBOutlet var stackView: SideBySideCardStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCards()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addCards()
    }
    
    func addCards() {
        let subview = Bundle(for: SideBySideCardView.self).loadNibNamed("\(SideBySideCardView.self)", owner: self)![0] as! SideBySideCardView
        addSubview(subview, constrainedTo: self)
    }
}
