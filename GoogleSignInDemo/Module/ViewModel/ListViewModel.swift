
import UIKit
import GoogleSignIn
//MARK:  - ListViewModelDelegate
protocol ListViewModelDelegate: AnyObject {
    func didFetchUsageData()
}
//MARK:  - ListViewModel
class ListViewModel {
    //MARK:  - Variables
    weak var delegate: ListViewModelDelegate?
    let networker = NetworkManager.shared
    var posts: [Post] = []
    var userProfile = GIDGoogleUser()
}
//MARK: - Functions
extension ListViewModel {
    func getListOfImages(){
        networker.posts(query: "puppies") { [weak self] posts, error in
            if let error = error {
                print("error", error)
                return
            }
            self?.posts = posts ?? []
            self?.delegate?.didFetchUsageData()
        }
    }
    func getImageData(post: Post) -> UIImage {
        var dataImage = UIImage()
        networker.image(post: post) { data, error  in
            let img = self.image(data: data)
            dataImage = img ??  UIImage()
        }
        return dataImage
    }
    
    func image(data: Data?) -> UIImage? {
        if let data = data {
            return UIImage(data: data)
        }
        return UIImage(systemName: "picture")
    }
}


