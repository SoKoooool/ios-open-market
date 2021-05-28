//
//  ListViewController.swift
//  OpenMarket
//
//  Created by steven on 2021/05/27.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "케인케인케인케인케인케인"
        cell.priceLabel.text = "KRW 1200000000"
        cell.discountedPriceLabel.text = "KRW 100000"
        cell.stockLabel.text = "잔여수량 : 148"
        cell.thumbnail.image = UIImage(named: "kane")
        
        return cell
    }
    
}
