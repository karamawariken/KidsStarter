//
//  SecondViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/13.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, URLSessionDelegate, URLSessionDataDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    @IBOutlet weak var AddImage1: UIButton!
    @IBOutlet weak var AddImage2: UIButton!
    @IBOutlet weak var AddImage3: UIButton!
    @IBOutlet weak var IntroductionTextField: UITextView!
    @IBOutlet weak var TitleTextField: UITextField!
    var  i:Int!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        TitleTextField.delegate = self
    }
    @IBAction func AddImageButton1(_ sender: Any) {
        i = 0;
        self.popupalert()
    }
    
    @IBAction func AddImageButton2(_ sender: Any) {
        i = 1;
        self.popupalert()
    }

    @IBAction func AddImageButton3(_ sender: Any) {
        i = 2;
        self.popupalert()
    }
    
    //投稿ボタンでpostとfileをrailsサーバーに送る
    @IBAction func postButton(_ sender: Any) {
        var json: NSData!
        
        //dictionaryで送信するJSONデータを生成
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict.setObject("1", forKey: "child_id" as NSCopying)
        dict.setObject(TitleTextField.text!, forKey: "title" as NSCopying)
        dict.setObject(IntroductionTextField.text!, forKey: "introduction" as NSCopying)
        dict.setObject("introduction_voice_link post test", forKey: "introduction_voice_link" as NSCopying)
        dict.setObject("image1_link post test", forKey: "image1_link" as NSCopying)
        dict.setObject("image2_link post test", forKey: "image2_link" as NSCopying)
        dict.setObject("image3_link post test", forKey: "image3_link" as NSCopying)
        dict.setObject("state post test", forKey: "state" as NSCopying)
        if JSONSerialization.isValidJSONObject(dict){
            
            do {
                
                // DictionaryからJSON(NSData)へ変換.
                json = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                
                // 生成したJSONデータの確認.
                print(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)
                
            } catch {
                print(error)
            }
            
        }
        
        
        //タイトルなどのテキストのJSONデータPOST時のコード
        //let config:URLSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundTask")
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        //セッションの生成
        let session:URLSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        //テキストデータpost先のURLを生成
        let postUrl:NSURL = NSURL(string: "http://192.168.100.100:3000/api/v1/products/1")!
        //POST用のリクエストを生成
        let request: NSMutableURLRequest = NSMutableURLRequest(url: postUrl as URL)
        //POSTメソッドを指定
        request.httpMethod = "POST"
        //jsonのデータを一度文字列にしてキーと合わせる
        let data:NSString = "\(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)" as NSString
        request.httpBody = data.data(using: String.Encoding.utf8.rawValue)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest)
        // タスクの実行.
        task.resume()
        
                
    }
    
    
    
    //画面外をタップした時にキーボードを下げる
    @IBAction func tapScreen(_ sender: Any) {
        view.endEditing(true)
    }
    
    //画像追加ボタンを押されたら発動
    private func popupalert(){
        let alertController = UIAlertController(title: "画像を選択", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラを起動", style: .default) { (UIAlertAction) -> Void in
            self.selectFromCamera()
        }
        let libraryAction = UIAlertAction(title: "カメラロールから選択", style: .default) { (UIAlertAction) -> Void in
            self.selectFromLibrary()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
    
    //Addimageをタップした時の処理 カメラを起動
    private func selectFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラ許可をしていない時の処理")
        }
    }
    //Addimageをタップした時の処理　フォトライブラリーを起動
    private func selectFromLibrary(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //選択された画像
        let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        if (i==0){
            AddImage1.setImage(selectImage, for: UIControlState())
            let image:UIImage = UIImage(named: "addimage")!
            AddImage2.setImage(image, for: UIControlState())
        }else if (i==1){
            AddImage2.setImage(selectImage, for: UIControlState())
            let image:UIImage = UIImage(named: "addimage")!
            AddImage3.setImage(image, for: UIControlState())
            
        }else if (i==2){
            AddImage3.setImage(selectImage, for: UIControlState())
            
        }
        self.dismiss(animated: true, completion: nil )
        
    }
    
    /*
     通信が終了したときに呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // 帰ってきたデータを文字列に変換.
        let getData:NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
        
        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
        DispatchQueue.main.async(execute: {
            //self.myTextView.text = getData as String
        })
    }
    
    /*
     バックグラウンドからフォアグラウンドの復帰時に呼び出されるデリゲート.
     */
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("URLSessionDidFinishEventsForBackgroundURLSession")
    } 
}

