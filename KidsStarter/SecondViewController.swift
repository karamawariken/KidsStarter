//
//  SecondViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/13.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import Alamofire
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
    var  image1_upload_check:Int!
    var  image2_upload_check:Int!
    var  image3_upload_check:Int!

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
        let myID:Int = 1
        //Alamoire画像uploadメソッド
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // 送信する値の指定をここでします
                if(self.image1_upload_check == 1){
                    self.addImageData(multipartFormData: multipartFormData, image: self.AddImage1.currentImage, image_with_name:"image1_link" )
                }
                if(self.image2_upload_check == 1){
                    self.addImageData(multipartFormData: multipartFormData, image: self.AddImage2.currentImage, image_with_name:"image2_link" )
                }
                if(self.image3_upload_check == 1){
                    self.addImageData(multipartFormData: multipartFormData, image: self.AddImage3.currentImage, image_with_name:"image3_link" )
                }
                
                //ここで投稿時にバリデーションかけるけれど、ここで存在確認してから送る
                if let data = self.TitleTextField.text?.data(using: String.Encoding.utf8){
                    multipartFormData.append(data, withName: "title")
                }
                if let data = self.IntroductionTextField.text?.data(using: String.Encoding.utf8){
                    multipartFormData.append(data, withName: "introduction")
                }
                if let data = "voice_data_link_hogehoge".data(using: String.Encoding.utf8){
                    multipartFormData.append(data, withName: "introduction_voice_link")
                }
                if let data = "state".data(using: String.Encoding.utf8){
                    multipartFormData.append(data, withName: "state")
                }
        },
            to: "http://192.168.100.102:3000/api/v1/products/\(myID)",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        // 成功
                        let responseData = response
                        print(responseData ?? "成功")
                    }
                case .failure(let encodingError):
                    // 失敗
                    print(encodingError)
                }
        }
        )

        
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
            //1枚目の画像が入ったと判断
            image1_upload_check = 1
            AddImage2.setImage(image, for: UIControlState())
        }else if (i==1){
            AddImage2.setImage(selectImage, for: UIControlState())
            let image:UIImage = UIImage(named: "addimage")!
            //2枚目の画像が入ったと判断
            image2_upload_check = 1
            AddImage3.setImage(image, for: UIControlState())
            
        }else if (i==2){
            //3枚目の画像が入ったと判断
            image3_upload_check = 1
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
        if getData != nil {
            print(getData)
        }
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
    
    //各画像を画像のデータ形式の判別とそれに合わせたデータの設定
    private func addImageData(multipartFormData: MultipartFormData, image: UIImage! , image_with_name: String){
        var data = UIImagePNGRepresentation(image!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        if data != nil {
            // PNG
            multipartFormData.append(data!, withName: image_with_name ,fileName: dateString + image_with_name, mimeType: "image/png")
        } else {
            // jpg
            data = UIImageJPEGRepresentation(image!, 1.0)
            multipartFormData.append((data?.base64EncodedData())!,  withName: image_with_name ,fileName: dateString + image_with_name, mimeType: "image/jpeg")
        }
        
    }
}

