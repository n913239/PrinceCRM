//
//  LoginViewController.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/25.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginData = member()
    struct PropertyKeys {
        static let first = "First"
        static let tabbar = "TabBar"
    }
    
    // 彈出警告視窗
    func showAlert(withTitle title:String, andMessage message:String, choiceMode  mode:UIAlertControllerStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: mode)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func signinButton(_ sender: UIButton) {

        let url = URL(string: "http://localhost:5000/api/Member")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dictionary = ["Username": "\(usernameTextField.text!)", "Password":"\(passwordTextField.text!)"]
        
        do {
            let data = try  JSONSerialization.data(withJSONObject: dictionary, options: [])
            
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res, error) in
                if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:String] {
                    // 記錄登入的資料，準備轉場的時候使用
                    guard let username = dic["username"], let token = dic["token"] else { return }
                    self.loginData.username = username
                    self.loginData.token = token
                    
                    // 轉場到下一個畫面
                    if let firstController = self.storyboard?.instantiateViewController(withIdentifier: PropertyKeys.first) as? FirstTableViewController, let tabController = self.storyboard?.instantiateViewController(withIdentifier: PropertyKeys.tabbar) as? UITabBarController {
                        firstController.user = self.loginData
                        // 將數值存入UserDefaults
                        let userDefault = UserDefaults.standard
                        userDefault.set(self.loginData.username, forKey: "user")
                        userDefault.set(self.loginData.token, forKey: "token")
                        userDefault.synchronize()
                        
                        // 呼叫 main thread 來轉換場景
                        DispatchQueue.main.async(execute: {
                            self.present(tabController, animated: true, completion: nil)
                        })
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        self.showAlert(withTitle: "Warning", andMessage: "username or password incorrect", choiceMode: UIAlertControllerStyle.alert)
                    })
                }
            })
            task.resume()
        }
        catch { }
        
        print("signinOK")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let firstController = segue.destination as? FirstTableViewController
        firstController?.user = loginData        
        
    }
    */

}

