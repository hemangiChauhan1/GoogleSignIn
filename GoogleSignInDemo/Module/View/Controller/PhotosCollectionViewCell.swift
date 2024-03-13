import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    //MARK: - @IBOutlet
    @IBOutlet weak var dataImage: UIImageView!
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
//MARK: - Configure Cell
extension PhotosCollectionViewCell {
    func configureCell(image: UIImage){
        dataImage.image = image
    }
}
