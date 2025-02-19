import UIKit

protocol ViewCode: AnyObject {
    func setupView()
    func addSubviews()
    func setupConstraints()
    func additionalSetup()
}

extension ViewCode {
    func setupView() {
        addSubviews()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {}
}
