//
//  ViewController.swift
//  DiffableExample
//
//  Created by 晋先森 on 10/31/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        loadLocalData()
    }
    
    func loadLocalData() {
        
        guard let path = Bundle.main.path(forResource: "xiehouyu", ofType: "json") else {
            print("file don't exist.")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([WordItem].self, from: data)
            print("words: \(words.count)")
            applyDataSource(words: words.reversed())
        } catch {
            print("error: \(error)")
        }
    }
    
    func applyDataSource(words: [WordItem]) {
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.word])
        snapshot.appendItems(words, toSection: .word)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: view.bounds, style: .insetGrouped)
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.register(UINib(nibName: "WordCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.delegate = self
        return view
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource<SectionType, WordItem> = {
        let source = UITableViewDiffableDataSource<SectionType, WordItem>(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, item: WordItem)
            -> WordCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WordCell
            cell?.item = item
            return cell
        }
        source.defaultRowAnimation = .fade
        return source
    }()
    
    lazy var dataSnapshot: NSDiffableDataSourceSnapshot<SectionType, WordItem> = {
        let snapshot = NSDiffableDataSourceSnapshot<SectionType, WordItem>()
        return snapshot
    }()

}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        var snapshot = dataSource.snapshot()
        selectedItem.riddle = selectedItem.riddle + " ★"
        
        snapshot.reconfigureItems([selectedItem])
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: {
            print("Done: \(selectedItem)")
        })
        
    }
}