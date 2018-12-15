//
//  ViewController.swift
//  SqliteDemo1
//
//  Created by student on 2018/12/8.
//  Copyright © 2018年 LiLin. All rights reserved.
//

import UIKit
import  SQLite3  //导入数据库sqlite3
class ViewController: UIViewController {

    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfName: UITextField!
    let db = SQLiteDB.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        let result =   db.open(dbPath: "", copyFile: true)//添加代码：拷贝文件
        print("result:\(result)")//true:表示该到数据库打开成功
        
        //建表
        let r = db.execute(sql: "create table if not exists Person(name varchar(20),phone varchar(20))")//添加“if not exists”是为了防止重复键表
        print("result:\(r)")
        
        print(NSHomeDirectory())  //寻找数据库data.db所在的位置(cmd命令行中进入该目录下的Documents文件就可以找到data.db数据库)
        print(Bundle.main.bundlePath)  //寻找daPath,得到目录
    }
    @IBAction func add(_ sender: Any) {
        let r = db.execute(sql: "insert into Person(name,phone) values('\(tfName.text!)','\(tfPhone.text!)')")
        print("result:\(r)")
        
    }
    
    @IBAction func update(_ sender: Any) {
        let r = db.execute(sql: "update Person set phone='\(tfPhone.text!)' where name = '\(tfName.text!)'")
        print("result:\(r)")
    }
    @IBAction func del(_ sender: Any) {
        let r = db.execute(sql: "delete from Person  where name ='\(tfName.text!)'")
        print("result:\(r)")
    }
    
    @IBAction func query(_ sender: Any) {
        let  persons = db.query(sql: "select *from Person where name = '\(tfName.text!)'")
        if let person = persons.first,let phone = person["phone"] as? String {
            tfPhone.text = phone
        }

    }
    
    
}

