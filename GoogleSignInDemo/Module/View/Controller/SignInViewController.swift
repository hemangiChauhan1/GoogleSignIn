
import UIKit
import GoogleSignIn

class SignInViewController: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var googleSignInBtn: UIButton!
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: - Configure Google SignIn
extension SignInViewController {
    func googleSignIn(){
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else { return }
            guard let signInResult = result else { return }
            self.moveToDetailListVC(guser: signInResult.user)
        }
    }
    func moveToDetailListVC(guser:GIDGoogleUser){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController{
            vc.userProfile = guser.profile
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
//MARK: - @IBAction
extension SignInViewController {
    @IBAction func googleSignInBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { giduser, error in
            guard error == nil else {
                self.googleSignIn()
                return
            }
            guard let signInUser = giduser else { return }
            self.moveToDetailListVC(guser: signInUser)
        }
    }
}

