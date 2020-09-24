import Foundation
import UIKit

@IBDesignable class CardView: UIControl {
    
    @IBOutlet var imageView: UIImageView!
    
    var card: Card! {
        didSet { imageView.image = card.image }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .none
        imageView.contentMode = .scaleAspectFit
    }
    
    func switchCard(to card: Card) {
        if self.card != card {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
                self.alpha = 0
            }, completion: { _ in
                self.card = card
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, animations: {
                    self.alpha = 1
                    self.transform = .identity
                })
            })
        }
    }
}
