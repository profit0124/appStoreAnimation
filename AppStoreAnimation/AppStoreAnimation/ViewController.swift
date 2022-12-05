//
//  ViewController.swift
//  AppStoreAnimation
//
//  Created by Sooik Kim on 2022/11/28.
//

import UIKit

class ViewController: UIViewController {
    
    private let images: [UIImage] = [UIImage(named: "0") ?? UIImage(), UIImage(named: "1") ?? UIImage()]
    private let texts: [String] = ["호미곷, 포항 첫 여행지", "트랙, In postech"]
    
    var selecetedCell: ImageTableViewCell?
    
    private let tableView: UITableView = {
        let view = UITableView()
        return view
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.frame = CGRect(x: 16, y: 16, width: view.frame.width - 32, height: view.frame.height - 32)
        view.addSubview(tableView)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        cell.setupImage(image: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell else { return }
        selecetedCell = cell
        print(selecetedCell?.frame)
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PresentViewController()
        vc.transitioningDelegate = vc.self
        vc.modalPresentationStyle = .overCurrentContext
        vc.setupData(text: texts[indexPath.row], image: images[indexPath.row])
        present(vc, animated: true)
    }
}
