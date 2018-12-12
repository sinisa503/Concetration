//
//  ConcentrationThemeChooserViewController.swift
//  Concetration
//
//  Created by Sinisa Vukovic on 11/12/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
   
   let themes = ["Sports":"⚽️🏈🎾🏐🏉🏓🏸🏑🥍🏏🏹🥊🛹🥊",
                 "Animals":"🐭🐹🐰🦊🐻🦁🐮🦆🦇🐺🐴🦄",
                 "Faces":"😁🤩😒🤒😷🤮😘😩☹️😓😡😭😠🤢"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      splitViewController?.delegate = self
   }

   @IBAction func goToGame(_ sender: Any) {
      if let cvc = detailViewController {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
         }
      } else if let cvc = previousDetailVC {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
         }
         self.navigationController?.pushViewController(cvc, animated: true)
      }
      else {
         self.performSegue(withIdentifier: "Choose theme", sender: sender)
      }
   }
   
   
   private var detailViewController: ConcentrationViewController? {
      return splitViewController?.viewControllers.last as? ConcentrationViewController
   }
   
   private var previousDetailVC:ConcentrationViewController?
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "Choose theme" {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            if let cvc = segue.destination as? ConcentrationViewController {
               cvc.theme = theme
               previousDetailVC = cvc
            }
         }
      }
   }
}

extension ConcentrationThemeChooserViewController: UISplitViewControllerDelegate {
   
   func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
      if let cvc = secondaryViewController as? ConcentrationViewController {
         if cvc.theme == nil {
            return true
         }
      }
      return false
   }
}
