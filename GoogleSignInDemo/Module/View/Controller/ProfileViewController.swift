import UIKit
import GoogleSignIn


class ProfileViewController: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    //MARK: - Variables
    var emailtext:String = ""
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
//MARK: - configureUI
extension ProfileViewController {
    func configureUI(){
        self.navigationController?.navigationBar.isHidden = false
        userNameLbl.text = emailtext
    }
}
//MARK: - @IBAction
extension ProfileViewController {
    @IBAction func signOutBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.popToRootViewController(animated: false)
    }
}
