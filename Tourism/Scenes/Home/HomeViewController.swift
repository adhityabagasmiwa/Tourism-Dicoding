//
//  HomeViewController.swift
//  Tourism
//
//  Created by Adhitya Bagas on 17/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var specialTourismCollectionView: UICollectionView!
    @IBOutlet weak var popularTourismCollectionView: UICollectionView!
    @IBOutlet weak var popularTourismConstraintCV: NSLayoutConstraint!
    
    var presenter: HomeViewToPresenterProtocol?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initAllCollectionView()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        let presenter: HomeInteractorToPresenterProtocol & HomeViewToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        
        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    func fetchData() {
        presenter?.fetchTourism()
    }
    
    private func initAllCollectionView() {
        initCollectionView(collectionView: specialTourismCollectionView, nibName: "SpecialTourismViewCell")
        initCollectionView(collectionView: popularTourismCollectionView, nibName: "PopularTourismViewCell")
        specialTourismCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        if let popularTourismCVLayout = popularTourismCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            popularTourismCVLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func initCollectionView(collectionView: UICollectionView, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.specialTourismCollectionView {
            return 4
        } else {
            return self.presenter?.popularTourism?.displayedTourism.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width-48
        if collectionView == self.specialTourismCollectionView {
            return CGSize(width: 118, height: 148)
        } else {
            return CGSize(width: width, height: 102)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.specialTourismCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialTourismViewCell", for: indexPath) as! SpecialTourismViewCell
            if let tourisms = self.presenter?.specialTourism?.displayedTourism {
                let tourism = tourisms[indexPath.row]
                let specialTourism : SpecialTourismCell = SpecialTourismCell(image: tourism.image, name: tourism.name, countLike: tourism.countLike)
                cell.setData(data: specialTourism)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTourismViewCell", for: indexPath) as! PopularTourismViewCell
            if let tourisms = self.presenter?.popularTourism?.displayedTourism {
                let tourism = tourisms[indexPath.row]
                let popularTourism : PopularTourismCell = PopularTourismCell(image: tourism.image, name: tourism.name, address: tourism.address, countLike: tourism.countLike)
                cell.setData(data: popularTourism)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.specialTourismCollectionView {
            if let tourisms = self.presenter?.specialTourism?.displayedTourism {
                let tourism = tourisms[indexPath.row]
                let data = Tourism(name: tourism.name, description: tourism.description, address: tourism.address, longitude: Double(tourism.longitude), latitude: Double(tourism.latitude), like: Int(tourism.countLike), image: tourism.image)
                let vc = DetailTourismRouter.createModule(tourism: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let tourisms = self.presenter?.popularTourism?.displayedTourism {
                let tourism = tourisms[indexPath.row]
                let data = Tourism(name: tourism.name, description: tourism.description, address: tourism.address, longitude: Double(tourism.longitude), latitude: Double(tourism.latitude), like: Int(tourism.countLike), image: tourism.image)
                let vc = DetailTourismRouter.createModule(tourism: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func showSpecialTourism() {
        self.specialTourismCollectionView.reloadData()
    }
    
    func showTourism() {
        let countTourism = self.presenter?.popularTourism?.displayedTourism.count ?? 0
        self.popularTourismConstraintCV.constant = CGFloat(102 * countTourism)
        self.popularTourismCollectionView.reloadData()
    }
    
    func showError(error: String) {
        debugPrint("ERROR", error)
    }
}
