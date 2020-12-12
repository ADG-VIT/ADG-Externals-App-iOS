//
//  ViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 27/11/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
    var dates:[String] = ["25","26","27"]
    var events:[String] = ["Recruitments Quiz","Hackgrid","iOS Fusion"]
    var venue:[String] = ["Venue: Online","Venue: Online","Venue: Online"]
    
    var arrImgData = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var askPageImage: UIImageView!
    @IBOutlet weak var askQuestionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func askQuestionPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Coming Soon...", message: "Chat room to share your doubts", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       askPageImage.layer.cornerRadius = 10
        
        arrImgData = [#imageLiteral(resourceName: "domains"),#imageLiteral(resourceName: "projects"),#imageLiteral(resourceName: "events"),#imageLiteral(resourceName: "teams")]
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            present(vc, animated: true)
        }
    }
    
    @IBAction func adgIconBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "about", sender: nil)
    }
    
   
}
//MARK:-TableView methods

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.dateLabel.text = dates[indexPath.row]
        cell.eventLabel.text = events[indexPath.row]
        cell.venueLabel.text = venue[indexPath.row]
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! HomeCollectionViewCell
        cells.imageViews.image = arrImgData[indexPath.row]
        
//        cells.layer.masksToBounds = false;
//        cells.layer.shadowOffset = CGSize(width: 0,height: 1)
//        cells.layer.shadowRadius = 5.0;
//        cells.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        cells.layer.shadowOpacity = 0.75;
        
        return cells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "domain", sender: nil)
        }
        else  if indexPath.item == 1 {
            self.performSegue(withIdentifier: "project", sender: nil)
        }
        else  if indexPath.item == 2 {
            self.performSegue(withIdentifier: "events", sender: nil)
        }
        else  if indexPath.item == 3 {
            self.performSegue(withIdentifier: "team", sender: nil)
        }
      }
}

//MARK:-  Onboarding Code

extension ViewController {
    
    class core{
        
        static let shared = core()
        
        func isNewUser()->Bool {
            return !UserDefaults.standard.bool(forKey: "onboarding")
        }
        
        func setIsNotNewUser() {
            UserDefaults.standard.set(true, forKey: "onboarding")
        }
    }
  



}
