import UIKit
import Foundation

@IBDesignable class CardSuperView: UIView {
    
    @IBAction func didTap(_ sender: CardView) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCardViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addCardViews()
    }
    
    func addCardViews() {
        for cardView in Bundle(for: CardView.self).loadNibNamed("\(CardView.self)", owner: self)! as! [CardView] {
            addSubview(cardView, constrainedTo: self)
        }
    }
}
