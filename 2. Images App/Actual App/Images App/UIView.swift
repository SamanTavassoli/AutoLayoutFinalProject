import UIKit

extension UIView {
    
    func addSubview(_ subview: UIView, constrainedTo anchorsView: UIView) {

        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
            ])
    }
}
