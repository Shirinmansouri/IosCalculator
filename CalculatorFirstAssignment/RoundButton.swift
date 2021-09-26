//
//  RoundButton.swift
//  CalculatorFirstAssignment
//
//  Created by Shirin Mansouri on 2021-09-24.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var roundButton:Bool=false{
        didSet{
            if roundButton
            {
                layer.cornerRadius=frame.height/4
            }
        }
    }

}
