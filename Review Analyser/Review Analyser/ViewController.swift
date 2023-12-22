//
//  ViewController.swift
//  Review Analyser
//
//  Created by Kushal Rajbhandari - fusemachines on 22/12/2023.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {

   //MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sentimentImageView: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    
   //MARK: - IBActions
    @IBAction func onClearPressed(_ sender: Any) {
        textView.text = ""
        clearButton.isHidden = true
    }
    
   //MARK: - Variables
    private lazy var sentimentClassifier: NLModel? = {
        let model = try? NLModel(mlModel: CreateML_ReviewClassifier().model)
        return model
    }()
    
    
    //MARK: - View Controller Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

//MARK: - Extension
extension ViewController : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !(textView.text.isEmpty), text == "\n"{
            if let label = sentimentClassifier?.predictedLabel(for: textView.text){
                switch label{
                case "positive":
                    sentimentImageView.image = UIImage(named: "positive")
                case "negative":
                    sentimentImageView.image = UIImage(named: "negative")
                default:
                    sentimentImageView.image = UIImage(named: "neutral")
                }
            }
        }
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        clearButton.isHidden = textView.text.isEmpty
    }
}

