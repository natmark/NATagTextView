//
//  ViewController.swift
//  Demo
//
//  Created by AtsuyaSato on 2017/04/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NATagTextViewDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagTextView: NATagTextView!
    var tags:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tagTextView.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK: - NATextViewDelegate
    func tagTextView(_ view: NATagTextView, didUpdateTags tags: [String]) {
        self.tags = tags
        tableView.reloadData()
    }
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
