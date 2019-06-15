//
//  GroupFeedVC.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 6/14/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleTxt: UILabel!
    @IBOutlet weak var sendMassegeView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var membersLbl: UILabel!
    
    var group: Group?
    var groupMessages = [Message]()
    func initGroup(group: Group) {
    self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMassegeView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleTxt.text = group?.groupTitle
        DataService.instance.getEmails(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessageForDesiredGroup(desiredGroup: self.group!, handler: { (returnedMessageGroup) in
                self.groupMessages = returnedMessageGroup
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUid: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (complete) in
                if complete {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
}
extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(image: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}
