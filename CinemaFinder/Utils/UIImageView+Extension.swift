import UIKit

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else { return }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data)  {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
    }
}
