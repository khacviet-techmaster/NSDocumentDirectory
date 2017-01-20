//
//  ViewController.swift
//  NSDocumentDirectory
//
//  Created by khacviet on 1/13/17.
//  Copyright © 2017 khacviet. All rights reserved.
//

import UIKit
import Photos
class ViewController: UIViewController {
    
    @IBOutlet weak var img_Images: UIImageView!
    @IBOutlet weak var img_TableImage: UIView!
    @IBOutlet weak var lbl_TableImageName: UIView!
    
    var fileList: NSArray? // mảng chứa tên các ảnh trong thư mục documentsPath
    var i: Int = 0
    var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)[0]
    let fileManager:FileManager = FileManager.default
    override func viewDidLoad() {
        super.viewDidLoad()
        fileList = listFilesFromDocumentsFolder() as NSArray?
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showImage), userInfo: nil, repeats: true)
//                documentsPath = documentsPath + "/wedding.jpg"
//                let url: NSURL = NSURL.fileURL(withPath: documentsPath) as NSURL
//                img_Images.image = UIImage(contentsOfFile: documentsPath)
    }
    
    func listFilesFromDocumentsFolder() -> [String]?
    {
        //        var theError = NSError()
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as? [String]
        if dirs != nil {
            let dir = dirs![0]
            do
            {
                if let fileList = try? FileManager.default.contentsOfDirectory(atPath: dir)
                {
                    return fileList   // edit: added ! for Swift 1.2 compatibitily
                }
            }
            catch let e as exception
            {
                print("e: \(e)")
            }
        }else{
            let fileList = [""]
            return fileList
        }
        return nil
    }
    func showImage() {
        let count = fileList?.count
        print(count)
        //        var isDir:Bool = true;
        if i == count! - 1  {
            i = 0
        }
        if i < count! - 1{
            print(i)
            i = i + 1
            if fileManager.fileExists(atPath: (fileList?[i])! as! String) != true
            {
                let fileURL = documentsPath + "/\((fileList?[i])!)"
                print(fileURL)
                img_Images.image = UIImage(contentsOfFile: fileURL)
            }
        }
    }
}
