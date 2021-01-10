//
//  ViewController.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit

class ResizingTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}

struct Widgets {
    private let colors = [UIColor.orange, UIColor.blue, UIColor.yellow, UIColor.brown]
    
    func getColor(index: Int) -> UIColor {
        let color = index == 0 ? colors.first! : colors[ index % colors.count]
        return color
    }
    
}

struct WidgetsImage {
    private let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4")]
    
    func getImage(index: Int) -> UIImage {
        let image = index == 0 ? images.first! : images[ index % images.count]
        return image!
    }
    
}

class ListViewController: UITableViewController {
    
    let widgets = WidgetsImage()
    
    override func loadView() {
        view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        tableView = ResizingTableView()
        self.view.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 2.0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell

//        let color = widgets.getColor(index: indexPath.row)
//        cell.backgroundColor = color
        
        let image = widgets.getImage(index: indexPath.row)
        cell.cellImage.image = image
        cell.tag = indexPath.row
        print("\(indexPath.row)")
        return cell
    }
    
}

