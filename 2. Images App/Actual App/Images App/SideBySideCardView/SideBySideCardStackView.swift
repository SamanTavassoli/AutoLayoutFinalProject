
import Foundation
import UIKit

@IBDesignable class SideBySideCardStackView: UIStackView {
    
    @IBAction func didTap(_ sender: CardView) {
        let viewController = referenceToViewController! as! ViewController
        viewController.selectedCardChanged(to: sender.card)
    }
    
    var referenceToViewController: UIViewController?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addCardViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCardViews()
    }
    
    func add() { // not used, just here for ref
        let nib = UINib(nibName: "\(CardView.self)", bundle: Bundle(for: CardView.self))
        for _ in 0...3 {
            addArrangedSubview(nib.instantiate(withOwner: self)[0] as! CardView)
        }
    }
    
    func addCardViews() { // same way as addCardViews but with loadNibNamed
        for _ in 0...3 {
            for cardView in Bundle(for: CardView.self).loadNibNamed("\(CardView.self)", owner: self)! as! [CardView] {
                addArrangedSubview(cardView)
            }
        }
    }
}
