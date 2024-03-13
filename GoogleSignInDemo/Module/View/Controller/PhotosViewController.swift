import UIKit
import Kingfisher
import GoogleSignIn

class PhotosViewController: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var listCollectionview: UICollectionView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var lblName: UILabel!
    //MARK: - Varibles
    var userProfile:GIDProfileData?
    let viewModel = ListViewModel()
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getListOfImages()
        lblName.text = userProfile?.name
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}
//MARK: - @IBAction
extension PhotosViewController {
    @IBAction func profileBtnAction(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController{
            if let emailid = userProfile?.email{
                vc.emailtext = emailid
            }
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout Methods
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let post = viewModel.posts[indexPath.item]
        let url = URL(string: post.urls.regular)
        let processor = DownsamplingImageProcessor(size: cell.dataImage.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 8)
        cell.dataImage.kf.indicatorType = .activity
        cell.dataImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "picture"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.height/5
        )
    }
}
//MARK: - ListViewModelDelegate
extension PhotosViewController: ListViewModelDelegate {
    func didFetchUsageData() {
        DispatchQueue.main.async {
            self.listCollectionview.reloadData()
        }
    }
}
