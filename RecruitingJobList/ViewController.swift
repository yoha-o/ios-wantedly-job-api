//
//  ViewController.swift
//  RecruitingJobList
//
//  Created by 大石 陽波 on 2019/09/16.
//  Copyright © 2019 Yoha Oishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var apiUrlStr = "https://www.wantedly.com/api/v1/projects"
    var jobList = [Job]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInitialData()
    }
    
    func fetchInitialData() {
        let url: URL = URL(string: self.apiUrlStr + "?page=1")!
        URLSession.shared.dataTask(with: url) {data, response, err in
            do {
                let dataModel: JsonResponse = try JSONDecoder().decode(JsonResponse.self, from: data!)
                DispatchQueue.main.async() { () -> Void in
                    self.jobList = dataModel.data
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.jobList.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        let job: Job = self.jobList[indexPath.row]
    
        let companyImage = cell.viewWithTag(1) as! UIImageView
        let companyImageData = NSData(contentsOf: job.company.avatar.s_100)
        companyImage.image = UIImage(data: companyImageData as! Data)
        
        let companyLabel = cell.viewWithTag(2) as! UILabel
        companyLabel.text = job.company.name
        
        let jobImage = cell.viewWithTag(3) as! UIImageView
        let jobImageData = NSData(contentsOf: job.image.i_320_131)
        jobImage.image = UIImage(data: jobImageData as! Data)
        
        let positionLabel = cell.viewWithTag(4) as! UILabel
        positionLabel.text = job.looking_for
        
        let jobTitleLabel = cell.viewWithTag(5) as! UILabel
        jobTitleLabel.text = job.title
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされたときの処理
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
}
