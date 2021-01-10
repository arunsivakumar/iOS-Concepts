//
//  ViewController.swift
//  EmbeddedTableView
//
//  Created by Arun Sivakumar on 10/1/21.
//

import UIKit


struct Widgets {
    private let colors = [UIColor.orange, UIColor.blue, UIColor.yellow, UIColor.brown]
    
    func getColor(index: Int) -> UIColor {
        let color = index == 0 ? colors.first! : colors[ index % colors.count]
        return color
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let widgets = Widgets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let color = widgets.getColor(index: indexPath.row)
        cell.backgroundColor = color
        cell.tag = indexPath.row
        print("\(indexPath.row)")
        return cell
    }
    
}

