//
//  LoginViewController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 12.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var scrollViewFirstScreen: UIScrollView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtom: UIScrollView!
    @IBOutlet weak var viewFirstScreen: UIView!
  
    
   
    let fromLoginToTabBarSegueIdentificator = "fromLoginToTabBar"
    
    let myFriendsArray = ["Петров", "Сидоров", "Ковалев","Иванов","Понкратов","Степанов","Ларин"]
    let reuseIdentifierMyFriends = "reuseIdentifierMyFriends"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOnFirstScreen), name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideOnFirstScreen), name: UIResponder.keyboardWillHideNotification, object: nil)
      
    let gesterRecognizerFirstScreen = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHideOnTap))
    scrollViewFirstScreen.addGestureRecognizer(gesterRecognizerFirstScreen)
     
    }

    
    
    
    
    @objc func keyboardWillShowOnFirstScreen(){
        scrollViewFirstScreen.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
    }
    
    @objc func keyboardWillHideOnFirstScreen(){
        scrollViewFirstScreen.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
 
    @objc func keyboardWillHideOnTap(){
        self.scrollViewFirstScreen.endEditing(true)
        
}
    
    func showAlertLoginAndPassword (message : String, completion : @escaping (UIAlertAction) -> Void){
        let alertShow = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        let alertActionButtom = UIAlertAction(title: "Ok", style: .destructive, handler: completion)
        alertShow.addAction(alertActionButtom)
        present(alertShow, animated: true, completion: nil)
        
    }
    
    
    @IBAction func loginButtom(_ sender: Any) {
       
        guard let myLogin = loginTextField.text,
              let myPassword = passwordTextField.text,
              !myLogin.isEmpty,
              !myPassword.isEmpty,
              myLogin == "root",
              myPassword == "12345"
       
        else {
            
            showAlertLoginAndPassword(message: "Не верный логин или пароль.") { _ in
                self.passwordTextField.text = ""
                self.loginTextField.text = ""
                      }
            return
        }
        
        performSegue(withIdentifier: fromLoginToTabBarSegueIdentificator, sender: nil)
                    
    }
    
}

extension LoginViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierMyFriends, for: indexPath)
   
        cell.textLabel?.text = myFriendsArray[indexPath.row]
      
        return cell
    
    }
    
    
}
