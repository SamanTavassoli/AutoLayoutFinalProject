
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var superview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
    }
    
    @IBAction func didTap(_ sender: Any) {
        
        superview.exchangeSubview(at: 0, withSubviewAt: 1)
        superview.exchangeSubview(at: 1, withSubviewAt: 2)
        superview.exchangeSubview(at: 2, withSubviewAt: 3)
        superview.exchangeSubview(at: 3, withSubviewAt: 4)
    }
    
    func addView() {
        let pokemonViews = [
            UIImageView(image: UIImage(named: "raichu")),
            UIImageView(image: UIImage(named: "drampa")),
            UIImageView(image: UIImage(named: "glaceon")),
            UIImageView(image: UIImage(named: "guzzlord"))
        ]
        
        for subview in pokemonViews {
            superview.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
                subview.widthAnchor.constraint(equalTo: superview.widthAnchor),
                subview.heightAnchor.constraint(equalTo: superview.heightAnchor)
                ])
            subview.contentMode = .scaleAspectFit
        }
    }
    
    
}

class SuperView: UIControl {
    
}
