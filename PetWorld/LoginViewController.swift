//
//  LoginViewController.swift
//  PetWorld
//
//  Created by my mac on 4/17/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorDisplay: UILabel!
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    
    @IBAction func onLoginTap(_ sender: UIButton) {
        let api = NetworkAPI.sharedInstance
        
        updateErrorDisplay(showErrorDisplay: false)
        
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        api.login(with: username, and: password) { (isValid: Bool, error: Error?) in
            OperationQueue.main.addOperation({ 
                if let error = error {
                    print("[ERROR]: \(error)")
                    self.errorDisplay.text = "Trouble logging in. Check internet connection and try again."
                    self.updateErrorDisplay(showErrorDisplay: true)
                }else if isValid {
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                }else {
                    self.errorDisplay.text = "Trouble logging in. Please try again."
                    self.updateErrorDisplay(showErrorDisplay: true)
                    //Try again upadate the GUI
                }
            })
          
        }
        
        
       // oldLogin()
        

        
    }
    
    
  
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        //If user presses the sign up button then go to the sign up screen
        //Probably uncessesary
      self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
        

        
        
        /*The following is code to set up the background video*/
        
        //Find the video in the project folder
        let URL = Bundle.main.url(forResource: "BGVideo", withExtension: "mp4")
        //Create AVPlayer object
        player = AVPlayer.init(url: URL!)
        //Until I find a way to strip audio....
        player.volume = 0.0
        
        
        //Create a player layer
        playerLayer = AVPlayerLayer(player: player)
        //Keep aspect ration
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        //Set the player layer dimensions to the views layer dimensions
        playerLayer.frame = view.layer.frame
        
        //Don't mess with video at the end
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        //Start the video
        player.play()
        
        //Insert the the player into the view
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //Create a callback for the event that the video stops so it replays again
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        
        
        
    }
    
    func playerItemReachEnd(notification: NSNotification){
        
        //Reset the video to start again
        player.seek(to: kCMTimeZero)
        
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateErrorDisplay(showErrorDisplay: Bool){
        if (showErrorDisplay){
            self.errorDisplay.isHidden = false
            passwordTextField.showRightView = true
            passwordTextField.updateView()
            
        }else{
            self.errorDisplay.isHidden = true
            passwordTextField.showRightView = false
        }
    
    }
    
    
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //
    }
    

}
