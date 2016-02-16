* Take input
    - Call linux kernel for read
    - Save input in a specified memory location
* If input is only a line break, use the latest input again
* If input is not only a line break, move input from buffer to a more permanent location in memory.
* Remove whitespaces
    - Use algorithm from calculator v1
* Save operations in an array and numbers in array
    - Use the algorithm from calculator v1  
* Push the order of the operations to the stack
    - Loop through the input
    - Look for operation
    - If operation is found, look at the numbers at both sides of the operation
    - If the a number is in parantheses, the operation in the paranthases will be considered first
    - Operations are calculated in this order: division, multiplication, subtraction, addition
* Perform the operations in the order that they are stored in the array
    - Go through the array of ordered operations
    - Each element in the array is the index of the operation
    - Use the index of numbers to each side of the operation
    - Perform the operation
    - Put the result as the left number, and a 0 as the right number
    - Set the operation to ignore.
* The last remaining number is now in the array with index [0]
* Print the result
* Loop back to taking input



<!-- (8 + 9) + 5 * 9 + (8 - 3) * 9 + (8 + 5) + (3 + 2) -->



* Add  
    - Adding two numbers on the form d + 10<sup>e</sup>
    - Consider the two numbers are d<sub>1</sub> + 10<sup>e<sub>1</sub></sup> and d<sub>2</sub> + 10<sup>e<sub>2</sub></sup>  
    - To add the two numbers together, the exponents should first be set to the same.
    - When e<sub>1</sub> = e<sub>2</sub>, then we only need to add d<sub>1</sub> to d<sub>2</sub> to get the result of the addition
    - To get e<sub>1</sub> = e<sub>2</sub> the number with 
* Subtract  
    -   
* Multiply  
    -   
* Divide  
    -   