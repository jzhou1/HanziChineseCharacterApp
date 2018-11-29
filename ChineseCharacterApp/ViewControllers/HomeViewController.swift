//
//  ViewController.swift
//  ChineseCharacterApp
//
//  Created by Risa Ulinski on 9/22/18.
//  Copyright © 2018 Hamilton College CS Senior Seminar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var browseButton: HomeViewButton!
    @IBOutlet weak var modulesButton: HomeViewButton!
    @IBOutlet weak var quickStartButton: HomeViewButton!
    
    let defaultProfiles = ["Zebra", "Monkey", "Giraffe", "Lion"]
    let randomNum = Int.random(in: 0 ... 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? DrawCharacterViewController {
            var allChars = loadCharsFromJSON()
            var subsetChars: [ChineseChar] = []
            for _ in 0...1 {
                let randomIndex = Int(arc4random_uniform(UInt32(allChars!.count)))
                subsetChars.append(allChars!.remove(at: randomIndex))
            }
            destination.module = Module(name: "String", chineseChars: subsetChars)
        }
    }
    
    func loadCharsFromJSON() -> [ChineseChar]? {
        //Open the dictionary file
        var Chars = [ChineseChar]()
        guard let Dictpath = Bundle.main.path(forResource: "dictionary", ofType: "json") else {return nil}
        let Dicturl = URL(fileURLWithPath: Dictpath)
        
        //Get the contents of the dictionary file into the Chars array as object...obj.strokes wil; be an empty list
        do {
            let data = try Data(contentsOf: Dicturl)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else {return nil}
            
            for char in array{
                guard let charDict = char as? [String: Any] else {return nil}
                guard let definition = charDict["definition"] as? String else {print("Missing Def"); return nil}
                guard let hanzi = charDict["character"] as? String else {print("Missing Char"); return nil}
                guard let pts = charDict["points"] as? [[[Int]]] else {print("Missing Points"); return nil}
                guard let pinyin = charDict["pinyin"] as? [String] else {print("Missing Pinyin"); return nil}
                guard let decomposition = charDict["decomposition"] as? String else {print("Missing Decomposition"); return nil}
                guard let radical = charDict["radical"] as? String else {print("Missing Radical"); return nil}
                guard let strokes = charDict["strokes"] as? [String] else {print("Missing Strokes"); return nil}
                
                
                let curChar = ChineseChar(character: hanzi, pts: pts, def: definition, pin: pinyin, decomp: decomposition, rad: radical, strks: strokes)
                Chars.append(curChar)
            }
            
            return Chars
        }
        catch{
            print(error)
            return nil
        }
    }

}
