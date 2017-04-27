//
//  CardsViewController.swift
//  tinder-animation
//
//  Created by Derrick Wong on 4/26/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var profileView: UIImageView!
    var cardInitialCenter: CGPoint!
    //var right = false;
    
    let tapRec = UIGestureRecognizer()
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.cardInitialCenter = self.profileView.center
        print(self.cardInitialCenter)
        
        
        self.profileView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedView(_:)))
        
        
        profileView.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tappedView(_ gesture: UITapGestureRecognizer){
        
        print("tapped")
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    

    @IBAction func didDragImage(_ sender: UIPanGestureRecognizer) {
//        self.cardInitialCenter = sender.location(in: view)
        let translation = sender.translation(in: view)
        if sender.state == .changed {
            let rotation = CGAffineTransform(rotationAngle: translation.x / 180)
            self.profileView.transform = rotation
            self.profileView.center = CGPoint(x: self.cardInitialCenter.x + translation.x, y: self.cardInitialCenter.y)
        } else if sender.state == .ended {
            
            if(translation.x > 80){
                print("swipe it away")
                let destinationCenter = CGPoint(x: 1000, y: self.cardInitialCenter.y)
                UIView.animate(withDuration:0.4, delay: 0.0,
                               options: [],
                               animations: { () -> Void in
                                self.profileView.center = destinationCenter
                }, completion: nil)
            } else if(translation.x < -80){
                print("swipe it away")
                let destinationCenter = CGPoint(x: -1000, y: self.cardInitialCenter.y)
                UIView.animate(withDuration:0.4, delay: 0.0,
                               options: [],
                               animations: { () -> Void in
                                self.profileView.center = destinationCenter
                }, completion: nil)
            } else{
                print("restore")
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                    self.profileView.center = self.cardInitialCenter
                    self.profileView.transform = .identity

                }, completion: nil)

            }
            
            
            //sender.view?.center = self.cardInitialCenter
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
