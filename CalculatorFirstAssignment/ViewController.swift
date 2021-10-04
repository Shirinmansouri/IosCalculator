 /*
  File : ViewController- Calculator Operation
  Author: Shirin Mansouri
  StudentId: 301131068
  
  Author: Ali Roudak
  StudentId: 301216533
  
  Last Modification Date: 03/October/2021
  
  Description: iOS Calculator
               This code is to realize a calculator with a regular range of operations, including summation, subtraction, multiplication, and division. It also is capable of calculating percentage of a number, changing a number's sign, making float numbers. This calculator could erase inputs when they are mistaken, and could clear off the whole display if necessary.
               To reach these goals, there are many functions defined. The core function in this code is named Calculation, which is responsible for execution of mathematical operations. This function (Calculation) is called by all four operators (+, -, /, *), and by (=) as well. To have calculations done, there are left-side value operand (named as "first"), right-side value operand (named "second") and an operator. The time all of these three elements are filled by the user, the arithmatic operation is accomplished and the result pops up on the screen. The result is also stored in variable first (left-side value operand), in case further operations are to be done on that.
               Full description of this code is already provided in a video which gives viewers a visual understanding of different sections within the code.
  
  
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
    var first = "0"
    var second = ""
    var finalResult = ""
    var CurrentOperation : OperationTypes = .NoOperation
    
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
        first = "0"
        second = ""
        CurrentOperation = .NoOperation
    }
// function for Backspace
    @IBAction func BackSpaceButtonPressed(_ sender: RoundButton) {
        if(!pressedNumbers.isEmpty)
        {
        pressedNumbers.removeLast()
       
        }
        if (pressedNumbers.count == 0)
        {
            pressedNumbers = "0"
            first = "0"
        }
        ResultLable.text = pressedNumbers
    }
        
      // function for percentage operation
    @IBAction func PercentageButtonPressed(_ sender: RoundButton) {
        var temp = ResultLable.text?.trimmingCharacters(in: .whitespaces)
        
        if(((temp?.count)!<11) && ((temp?.count)! + 2)<11)
        {
            let result: Double = Double(temp!)! / (100)
            pressedNumbers = FormatingDouble(temp: result)
            ResultLable.text = FormatingDouble(temp: result)
            
        }
        else{
            var counter = 0
            while((temp?.first == "0") || (temp?.first == ".")){
                temp?.removeFirst()
                counter += 1
            }
            counter -= 1
            var residual = Double(temp!)!
            while(residual >= 10.0){
                residual /= 10.0
            }
            var toShow = FormatingDouble(temp: residual)
            counter += 2
            toShow += "e-" + String(counter)
            pressedNumbers = toShow
            ResultLable.text = toShow
        }
    }
     
   // function for equal operation
    @IBAction func EqualButtonPressed(_ sender: RoundButton) {
        if(CurrentOperation != .NoOperation){
            let newVar : OperationTypes = .Equal
        Calculation(operationType: newVar)
        }
    }
    
    // function for pluse/minus button operation
    @IBAction func PlusMinusButtonPressed(_ sender: RoundButton) {
        
        if(CurrentOperation == .NoOperation){
        let temp : String = (ResultLable.text?.trimmingCharacters(in: .whitespaces))!
        if(temp.first != "-" )
        {
            ResultLable.text = "\("-")\(temp)"
            pressedNumbers = "\("-")\(temp)"
        }
        else{
            let funny = (Double(temp)! * (-1))
            ResultLable.text = FormatingDouble(temp: funny)
            pressedNumbers = FormatingDouble(temp: funny)
            
        }
        }
        else{
            if(pressedNumbers == ""){
                ResultLable.text = "-0"
                pressedNumbers = "-0"
            }
            else{
                let temp : String = (ResultLable.text?.trimmingCharacters(in: .whitespaces))!
                if(temp.first != "-" )
                {
                    ResultLable.text = "\("-")\(temp)"
                    pressedNumbers = "\("-")\(temp)"
                }
                else{
                    let funny = (Double(temp)! * (-1))
                    ResultLable.text = FormatingDouble(temp: funny)
                    pressedNumbers = FormatingDouble(temp: funny)
                    
                }
            }
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
                if(operationType != .Equal){
                    CurrentOperation = operationType
                }
                else{
                    CurrentOperation = .NoOperation
                }
                
            }
            else{
            CurrentOperation = operationType
            }
        }
        else
        {
            if(pressedNumbers != ""){
            first = pressedNumbers
            pressedNumbers = ""
            }
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
            var formattedValue = String(format: "%.8f", Double(result)!)
            while(formattedValue.last == "0"){
                formattedValue.removeLast()
            }
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

