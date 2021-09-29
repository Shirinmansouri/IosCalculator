 /*
  File : ViewController- Calculator Operation
  Author: Shirin Mansouri
  StudentId: 301131068
  
  Author: Ali Roudak
  StudentId: 301131068
  
  ModifiedDate: 25/September/2021
  Description: Calculator
  
  
  */

import UIKit
enum OperationTypes: String
{
    case NoOperation = ""
    case sum = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case percentage = "%"
    case Equal = "="
    
}

class ViewController: UIViewController {
    @IBOutlet weak var ResultLable: UILabel!
    @IBOutlet var vwCalc: UIView!
    
    var pressedNumbers=""
    var first = ""
    var seconde = ""
    var finalResult = ""
    var CurrentOperation : OperationTypes = .NoOperation
    var IsNegetiveFirst = 1
    var IsNegetiveSecond = 1
    
    override func viewDidLoad() {
        ResultLable.text="0"
    }

    @IBAction func PressNumberButton(_ sender: RoundButton) {
  
        if (pressedNumbers.count<11)
        {
            
        if (pressedNumbers.starts(with: "-0") )
        {
                pressedNumbers = "-"
        }
        if ("\(sender.tag)")=="0" && (pressedNumbers.isEmpty)
        {
            pressedNumbers="0"
        }
        
        else if ("\(sender.tag)")=="0" && (pressedNumbers.starts(with: "0"))
        {
            pressedNumbers="0"
            
        }
        else if (("\(sender.tag)") != "0") && (pressedNumbers.starts(with: "0."))
        {
            pressedNumbers = "\(pressedNumbers)\(sender.tag)"
        }
        else if (("\(sender.tag)") != "0") && (pressedNumbers.starts(with: "0"))
        {
            pressedNumbers="\(sender.tag)"
        }
        else
        {
            pressedNumbers = "\(pressedNumbers)\(sender.tag)"
        }
        ResultLable.text =  pressedNumbers
        }
    }
    
    @IBAction func DivideButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.divide)
    }
    @IBAction func SummationButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.sum)
    }
    
    @IBAction func SubtractButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.minus)
    }
    @IBAction func MultiplButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.multiply)
    }
    
    @IBAction func DotButtonPressed(_ sender: RoundButton) {
        if (pressedNumbers.count<10)
        {
        if (pressedNumbers.isEmpty)
        {
            pressedNumbers="\("0").\(pressedNumbers)"
            
        }
        else if (pressedNumbers.contains("."))
        {
            pressedNumbers = "\(pressedNumbers)"
        }
         else
         {
             pressedNumbers = "\(pressedNumbers)\(".")"
         }
        
            ResultLable.text =  pressedNumbers
            
        }
    }
    
    
    @IBAction func ClearButtonPressed(_ sender: RoundButton) {
        ResultLable.text="0"
        pressedNumbers=""
        finalResult = ""
        first = ""
        seconde = ""
        CurrentOperation = .NoOperation
    }

    @IBAction func BackSpaceButtonPressed(_ sender: RoundButton) {
        if(!pressedNumbers.isEmpty)
        {
        pressedNumbers.removeLast()
       
        }
        if (pressedNumbers.count == 0)
        {
            pressedNumbers = "0"
        }
        ResultLable.text = pressedNumbers
    }
        
        
    @IBAction func PercentageButtonPressed(_ sender: RoundButton) {
        var temp = ResultLable.text?.trimmingCharacters(in: .whitespaces)
        if ((temp?.count)!<=11)
        {
            let result: Double = Double(temp!)! / (100)
            pressedNumbers = FormatingDouble(temp: result)
            ResultLable.text = FormatingDouble(temp: result)
            
        }
    }
     
   
    @IBAction func EqualButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: CurrentOperation)
    }
    @IBAction func PlusMinusButtonPressed(_ sender: RoundButton) {
        
        var temp : String = (ResultLable.text?.trimmingCharacters(in: .whitespaces))!
        if (temp.first != "-" )
        {
            ResultLable.text = "\("-")\(temp)"
            pressedNumbers = "\("-")\(temp)"
        }
         
       
    }
    
    func FormatingDouble(temp: Double) -> String {
        var formattedValue = String(format: "%.10f", temp)
        while formattedValue.last == "0" {
                    formattedValue.removeLast()
                }
        if formattedValue.last == "." {
                    formattedValue.removeLast()
                }
   
     /*   while formattedValue.count > 10 {
                        formattedValue.removeLast()
                    }*/
        
        return formattedValue
    }
    func Calculation(operationType: OperationTypes) {
       
        if (CurrentOperation != .NoOperation)
        {
            if (pressedNumbers != "")
            {
            seconde = pressedNumbers
            pressedNumbers=""
               
            if (CurrentOperation == .divide)
            {
                finalResult = "\( Double(first)! / Double(seconde)!)"

            }
            else if (CurrentOperation == .minus)
            {
                finalResult = "\( Double(first)! - Double(seconde)!  )"
            }
            else if (CurrentOperation == .multiply)
            {
                finalResult = "\( Double(first)!  * Double(seconde)!  )"
            }
            else if (CurrentOperation == .sum)
            {
                finalResult = "\( Double(first)!  + Double(seconde)! )"
            }
                first = finalResult
                ResultLable.text = FormatFinalResult(result: finalResult)
                
        }
            CurrentOperation = operationType
        }
        else
        {
            first = pressedNumbers
            pressedNumbers = ""
            CurrentOperation = operationType
        }
            
    }
    
    func FormatFinalResult(result : String) -> String
    {
        if (Double(result)!.truncatingRemainder(dividingBy: 1)==0)
        {
            let temp = Int(Double(result)!)
            return "\(temp) "
        }
        else
        {
            let formattedValue = String(format: "%.2f", Double(result)!)
            return formattedValue
        }
           
    }
}

