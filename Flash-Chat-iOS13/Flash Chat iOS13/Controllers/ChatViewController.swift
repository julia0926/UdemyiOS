//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.hidesBackButton = true //뒤로가기 버튼 안보이게
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        
        //.addSnapshotListener로 바꿔주면 실시간으로 데이터 수신을 대기
        //Firestore에서 데이터 가져옴

        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener  { (QuerySnapshot, error) in //수신 날짜 순으로 order 
            self.messages = []
            if let e = error {
                print("Firestore에서 데이터 가져오는 것 실패 : \(e)")
            }else {
                if let snapshotDocuments = QuerySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async { //이 부분은 메인 스레드에서 실행되야 함 업데이트될 때
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0) //섹션은 없음
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true) //테이블 뷰가 스크롤 마지막 대화 메세지로
                                
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName) //message 
                .addDocument(data: [K.FStore.senderField: messageSender,
                                    K.FStore.bodyField: messageBody,
                                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                    if let e = error {
                        print("데이터 저장하는데 문제 생김: \(e)")
                    }else {
                        print("Sucessfully saved data")
                        DispatchQueue.main.async {
                            self.messageTextfield.text = ""
                        }
                    }
                }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
      
    }
    
}


extension ChatViewController: UITableViewDataSource{ //테이블 뷰 데이터에 대한
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //테이블 resource 몇 개 만들껀지
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell //이미 만들어 놓은 MessageCell로 치환
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email { // 현재 로그인 한 사람의 이메일 이라면 cell의 디자인 정함
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
            
        }
        
        return cell
    }
    
    
}

extension ChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
