//
//  ViewController.swift
//  old-calculator
//
//  Created by Разработчик on 15.07.15.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var outResult: UILabel!
    
    var _number:String = "";
    var _action:String = "";
    var _buf_tmp:String = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!);
        for button in self.buttons {
            if let bt_text:String = button.titleLabel?.text {
                let image = UIImage(named: (bt_text == "C" || bt_text == "CE") ? "bg_bt_red" : "bg_bt_black")!;
                var tempImage:UIImage?;
                var targetSize = CGSize(width: button.frame.size.width, height: button.frame.size.height);
                UIGraphicsBeginImageContext(targetSize);
                var thumbnailRect = CGRect.zeroRect;
                thumbnailRect.origin = CGPointMake(0.0,0.0);
                thumbnailRect.size.width  = targetSize.width;
                thumbnailRect.size.height = targetSize.height;
                image.drawInRect(thumbnailRect);
                tempImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                button.backgroundColor = UIColor(patternImage: tempImage!);
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    var _action_on_clck = false;
    @IBAction func onActionNumbers(sender: UIButton) {
        if let number:String = sender.titleLabel?.text {
            if count((self.outResult.text!).utf16) < 7 {
                if (self._action_on_clck) {
                    self._buf_tmp = self.outResult.text!;
                    self.outResult.text = number;
                    self._action_on_clck = false;
                } else {
                    if self._number == "" {
                        self.outResult.text = "\(self._number)\(number)";
                    } else {
                        self.outResult.text = "\((self.outResult.text)!)\(number)";
                    }
                }
                self._number = number;
            }
        }
    }

    @IBAction func onActionActions(sender: UIButton) {
        if let action:String = sender.titleLabel?.text {
            if action == "=" && self._action != "" {
                let _b_ = (self._buf_tmp as NSString).floatValue;
                let _n_ = ((self.outResult.text!) as NSString).floatValue;

                if self._action == "+" {
                    self.writeResult((_b_ + _n_));
                } else if self._action == "-" {
                    self.writeResult((_b_ - _n_));
                } else if self._action == "x" {
                    self.writeResult((_b_ * _n_));
                } else if self._action == "/" {
                    self.writeResult((_b_ / _n_));
                }
            }
            
            self._action_on_clck = true;
            self._action = action;
        }
    }

    private func writeResult(res_f:Float) {
        var result = "";
        if (res_f % 1) == 0.0 {
            result = "\(Int(res_f))";
        } else {
            result = "\(res_f)";
        }
        self.outResult.text = result;
    }
    
    @IBAction func onActionClear(sender: UIButton) {
        self._action = "";
        self._number = "";
        self._buf_tmp = "";
        self._action_on_clck = false;
        self.outResult.text = "0";
    }
}

