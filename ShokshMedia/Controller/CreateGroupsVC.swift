//
//  CreateGroupsVC.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 5/29/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//
import Firebase
import UIKit

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailSearchLbl: UILabel!
    @IBOutlet weak var emailSearchField: InsetTextField!
    @IBOutlet weak var descriptionField: InsetTextField!
    @IBOutlet weak var titleField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchField.delegate = self
        emailSearchField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChanged() {
        if emailSearchField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(query: emailSearchField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func donePressed(_ sender: Any) {
        if titleField.text != "" && descriptionField.text != "" {
            DataService.instance.getIds(usernames: chosenUserArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(title: self.titleField.text!, description: self.descriptionField.text!, ids: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group can't be created, try again later.")
                    }
                })
            }
        }
    }
}
extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(email: emailArray[indexPath.row], profileImage: profileImage!, isSelected: true)
        } else {
            cell.configureCell(email: emailArray[indexPath.row], profileImage: profileImage!, isSelected: false)
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            emailSearchLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text! })
            if chosenUserArray.count >= 1 {
                emailSearchLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                emailSearchLbl.text = "Add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}
extension CreateGroupsVC: UITextFieldDelegate {
    
}
