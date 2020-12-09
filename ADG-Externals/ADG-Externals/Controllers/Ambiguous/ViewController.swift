//
//  ViewController.swift
//  ADG-Externals
//
//  Created by PRABALJIT WALIA     on 27/11/20.
//

import UIKit

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dates:[String] = ["25","26","27"]
    
    @IBOutlet weak var tableView: UITableView!
    
        fileprivate let data = [
            CustomData(title: "Basics of ML", url: "https://www.udemy.com", backgroundImage:#imageLiteral(resourceName: "juan-carlos-gomez-rt2_-5PI2UU-unsplash")),
            CustomData(title: "Basics of Swift", url: "https://www.udemy.com", backgroundImage:#imageLiteral(resourceName: "kathy-symonds-DuoMpJ1P8bc-unsplash") ),
            CustomData(title: "Basics of Java", url: "https://www.udemy.com", backgroundImage:#imageLiteral(resourceName: "lance-asper-jUDyzB7idz8-unsplash") ),
            CustomData(title: "Collection Views!", url: "https://www.udemy.com", backgroundImage: #imageLiteral(resourceName: "claudia-lam-BPy_w7rG6bk-unsplash"))
        ]
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //MARK:- Onboarding Stuffs
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            present(vc, animated: true)
        }
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.3, height: collectionView.frame.width/1.3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.item]
        
        return cell
    }
    
    func buttonTappedInCollectionViewCell(sender: UIButton) {
           self.performSegue(withIdentifier: "toStoreFromMyDiscounts", sender: nil)
       }
    //MARK:-TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.dateLabel.text = dates[indexPath.row]
        return cell
        
    }
}


class CustomCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            bg.image = data.backgroundImage
            
        }
    }
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        


        
        contentView.addSubview(bg)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
