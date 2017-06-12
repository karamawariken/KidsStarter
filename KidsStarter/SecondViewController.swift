//
//  SecondViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/13.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var AddImage1: UIButton!
    @IBOutlet weak var AddImage2: UIButton!
    @IBOutlet weak var AddImage3: UIButton!
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
        
        /* 画像がnoimageじゃなかったらとかにしたい
         if(AddImage1.currentImage == "noimage"){
        }
         */
    }
    
    @IBAction func AddImageButton2(_ sender: Any) {
        i = 1;
        self.popupalert()
    }

    @IBAction func AddImageButton3(_ sender: Any) {
        i = 2;
        self.popupalert()
    }
    @IBAction func postButton(_ sender: Any) {
    }
    
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
}

