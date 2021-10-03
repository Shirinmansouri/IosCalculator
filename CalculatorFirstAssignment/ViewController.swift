 /*
  File : ViewController- Calculator Operation
  Author: Shirin Mansouri
  StudentId: 301131068
  
  Author: Ali Roudak
  StudentId: 301216533
  
  ModifiedDate: 25/September/2021
  Description: Calculator
  
  
  */

import UIKit
// functions type enumeration
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
    var second = ""
    var finalResult = ""
    var CurrentOperation : OperationTypes = .NoOperation
    var IsNegetiveFirst = 1
    var IsNegetiveSecond = 1
    
    override func viewDidLoad() {
        ResultLable.text="0"
    }

    // function for all numbers buttons
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
    
    
    // function for dot button
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
    
    // function for clear operation
    @IBAction func ClearButtonPressed(_ sender: RoundButton) {
        ResultLable.text="0"
        pressedNumbers=""
        finalResult = ""
        first = ""
        second = ""
        CurrentOperation = .NoOperation
    }
// function for percentage operation
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
        
      // function for percentage operation
    @IBAction func PercentageButtonPressed(_ sender: RoundButton) {
        var temp = ResultLable.text?.trimmingCharacters(in: .whitespaces)
        if ((temp?.count)!<=11)
        {
            let result: Double = Double(temp!)! / (100)
            pressedNumbers = FormatingDouble(temp: result)
            ResultLable.text = FormatingDouble(temp: result)
            
        }
    }
     
   // function for equal operation
    @IBAction func EqualButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: CurrentOperation)
    }
    
    // function for pluse/minus button operation
    @IBAction func PlusMinusButtonPressed(_ sender: RoundButton) {
        
        var temp : String = (ResultLable.text?.trimmingCharacters(in: .whitespaces))!
        if (temp.first != "-" )
        {
            ResultLable.text = "\("-")\(temp)"
            pressedNumbers = "\("-")\(temp)"
        }
         
       
    }
    
    // function for formatting the result of percentage function
    func FormatingDouble(temp: Double) -> String {
        var formattedValue = String(format: "%.10f", temp)
        while formattedValue.last == "0" {
                    formattedValue.removeLast()
                }
        if formattedValue.last == "." {
                    formattedValue.removeLast()
                }

        
        return formattedValue
    }
    // the core function of calculator
    func Calculation(operationType: OperationTypes) {
       
        if (CurrentOperation != .NoOperation)
        {
            if (pressedNumbers != "")
            {
            second = pressedNumbers
            pressedNumbers=""
               
            if (CurrentOperation == .divide)
            {
                finalResult = "\( Double(first)! / Double(second)!)"

            }
            else if (CurrentOperation == .minus)
            {
                finalResult = "\( Double(first)! - Double(second)!  )"
            }
            else if (CurrentOperation == .multiply)
            {
                finalResult = "\( Double(first)!  * Double(second)!  )"
            }
            else if (CurrentOperation == .sum)
            {
                finalResult = "\( Double(first)!  + Double(second)! )"
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
    
    // function for formatting the final result of calculation
    func FormatFinalResult(result : String) -> String
    {
        if (Double(result)!.truncatingRemainder(dividingBy: 1)==0)
        {
            let temp = Int(Double(result)!)
            return "\(temp) "
        }
        else
        {
            // floating number accurate to 8 decimal number
            let formattedValue = String(format: "%.8f", Double(result)!)
            return formattedValue
        }
           
    }
    
    // divid function
    @IBAction func DivideButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.divide)
    }
    //summation function
    @IBAction func SummationButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.sum)
    }
    //substarct function
    @IBAction func SubtractButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.minus)
    }
    // multiple function handler
    @IBAction func MultiplButtonPressed(_ sender: RoundButton) {
        Calculation(operationType: OperationTypes.multiply)
    }
    
}

