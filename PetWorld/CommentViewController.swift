//
//  CommentViewController.swift
//  PetWorld
//
//  Created by my mac on 7/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
   var comments: [Comment] = []
   var keyboardHeight: CGFloat = 0.0
   
    
    //The post that comment is being reffered by
    var post: Post?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    
    
    @IBAction func onCommentStartEditing(_ sender: AnyObject) {
        print("comment start")
       // self.resignFirstResponder()
       // print(self.keyboardHeight)
        
       
        
    }
    
    
    @IBAction func onCommentEditingEnd(_ sender: Any) {
        print("comment end")
        print(self.keyboardHeight)
        self.commentTextField.resignFirstResponder()

        UIView.animate(withDuration: 0.2) {
            self.bottomConstraint.constant = 50
            self.commentTextField.layoutIfNeeded()
        }
    }
    
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            print("Back button pressed.")
        }
    }
    

    @IBAction func onPostButtonTapped(_ sender: Any) {
        let api = NetworkAPI.sharedInstance
        //Create new comment an init member fields
        
        let newComment = Comment(text: self.commentTextField.text!, authorId: (Pet.currentPet()?.objectId)!, postId: (self.post?.objectId!)!)
        //Actual object links for local use
        newComment.author = Pet.currentPet()
        newComment.post = self.post
    
            //Autmatically update comments locally.
            comments.append(newComment)
        
        
        self.createComment(comment: newComment)
        self.commentTextField.text = ""
        self.commentTextField.endEditing(true)
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 600
        
        self.tableView.reloadData()
        self.tableView.allowsSelection = false
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:  .keyboardWillShow, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){
         let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        self.keyboardHeight = (keyboardSize?.height)!
        
        
        print("keyboardWillShow() called!\n_________\n\(keyboardSize)___________")
        UIView.animate(withDuration: 0.2) {
            self.bottomConstraint.constant = self.keyboardHeight + self.commentTextField.frame.size.height
        }
        
        
    
    }
    
    
    
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return comments.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        
        
        let comment = comments[indexPath.row]
     
        cell.comment =  comment
       
        return cell
        
    }
    
    
      
    func createComment(comment: Comment){
        let api = NetworkAPI.sharedInstance
        api.postComment(comment: comment) { (succeeded: Bool?, error: Error?) in
            if let error = error {
                 print("[ERROR]: \(error)")
            }else if let succeeded = succeeded {
                if succeeded {
                    print("Successfully created comment!")
                }
            }
        }
    }
}

private extension Selector{
    static let keyboardWillShow = #selector(CommentViewController.keyboardWillShow(notification:))
    
}
