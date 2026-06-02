use std::io::Write;
use rand::Rng;
use regex::Regex;


// The function to get the minimum or maximum value in a list of numbers
fn get_max_or_min(number_list: Vec<f64>, max: bool) -> f64 {

    // Initialise the compare variable to store the comparison function.
    // The comparison function is greater than if the maximum is wanted
    // and less than if the minimum is wanted.
    let compare = if max { f64::gt } else { f64::lt };

    // Initialise the critical number,
    // which is either the maximum or minimum number,
    // to the first number in the list
    let mut critical_number = number_list[0];

    // Iterates over the array of numbers
    for number in number_list.iter() {

        // Ohterwise, compare the two numbers.
        // If the encountered number is greater or less than
        // the critical number (depends on the comparison function)
        if compare(number, &critical_number) {

            // Set the critical number to the
            // encountered number
            critical_number = *number;
        }

        // Otherwise, continue the loop
    }

    // Return the critical number
    critical_number
}


// The function to solve a quadratic equation
fn solve_quadratic_eqn() {

    // The list of terms
    let terms = ["x^2", "x", "constant"];

    // Initialise the hashmap to store the coefficients
    let mut coefficients = std::collections::HashMap::<&str, f64>::new();

    // Iterates over the coefficients
    for term in terms {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("Please enter the coefficient for the {} term: ", term);

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Set the value in the hashmap
                    coefficients.insert(term, value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Gets the values for a, b and c
    let a = *coefficients.get("x^2").unwrap();
    let b = *coefficients.get("x").unwrap();
    let c = *coefficients.get("constant").unwrap();

    // Get the discriminant
    let discriminant = b.powi(2) - 4.0 * a * c;

    // Gets the part after the plus minus function
    let part_after_plus_minus = f64::sqrt(discriminant.abs()) / (2.0 * a);

    // Prints the word "Results:"
    println!("Results:");

    // Check if the discriminant is more than or equal to zero
    match discriminant >= 0.0 {

        // If the discriminant is more than or equal to 0
        true => {

            // Check if the part after the plus minus is zero
            match part_after_plus_minus == 0.0 {

                // If it is, just print the front part
                true => println!("{}", (-b / 2.0 * a)),

                // Otherwise
                false => {

                    // Prints the results normally
                    println!("{} or", (-b / 2.0 * a) + part_after_plus_minus);
                    println!("{}", (-b / 2.0 * a) - part_after_plus_minus);
                }
            }
        },

        // If the discriminant is less than 0
        false => {

            // Prints the result with the i to signify a complex number
            println!("{} + {}i or", (-b / 2.0 * a), part_after_plus_minus);
            println!("{} - {}i", (-b / 2.0 * a), part_after_plus_minus);
        }
    }
}


// Function to compute the volume and the surface area of a sphere
fn compute_surface_area_and_volume_of_sphere() {

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Initialise the variable to store the radius
    let mut radius = 0.0;

    // While the input is not numeric
    while !is_number {

        // Print the prompt
        print!("Enter the radius of the sphere: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Set radius to the value
                radius = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Calculate the surface area of the sphere
    let surface_area = 4.0 * std::f64::consts::PI * radius.powi(2);

    // Calculate the volume of the sphere
    let volume = (4.0 / 3.0) * std::f64::consts::PI * radius.powi(3);

    // Prints the surface area and volume
    println!("Surface area of the sphere: {}", surface_area);
    println!("Volume of the sphere: {}", volume);
}


// The function to solve a simultaneous equation of the form:
// a1x + b1y = c1
// a2x + b2y = c2
fn compute_simultaneous_eqn_solutions() {

    // The hashmap to store all the data from the user
    let mut coefficients = std::collections::HashMap::<&str, f64>::new();

    // Iterates over all the coefficients
    for term in ["a1", "b1", "c1", "a2", "b2", "c2"] {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("  {}: ", term);

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Adds the user input to the hashmap
                    coefficients.insert(term, value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Gets all the coefficients of the simultaneous equations
    let a1 = *coefficients.get("a1").unwrap();
    let b1 = *coefficients.get("b1").unwrap();
    let c1 = *coefficients.get("c1").unwrap();
    let a2 = *coefficients.get("a2").unwrap();
    let b2 = *coefficients.get("b2").unwrap();
    let c2 = *coefficients.get("c2").unwrap();

    // Calculate x and y
    let x = (b2 * c1 - b1 * c2) / (a1 * b2 - a2 * b1);
    let y = (a1 * c2 - a2 * c1) / (a1 * b2 - a2 * b1);

    // Print the solutions
    println!("x = {}", x);
    println!("y = {}", y);
}


// The function to print whether a given integer is even or odd
fn even_or_odd() {

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Initialise the integer than the user gave
    let mut integer = 0;

    // While the input is not numeric
    while !is_number {

        // Print the prompt
        print!("Enter an integer: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<i64>() {

            // If there are no errors
            Ok(value) => {

                // Sets the integer variable to the user's input
                integer = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // The string that says even or odd
    let even_or_odd_string = if integer % 2 == 0 { "even" } else { "odd" };

    // Tells the user that the integer is even or odd
    println!("The integer {} is {}", integer, even_or_odd_string);
}


// The function to calculate a person's BMI
fn calculate_bmi() {

    // The hashmap storing the variables and the prompts
    let prompt_mapping = std::collections::HashMap::from([
        ("weight", "Please enter your weight in kg: "),
        ("height", "Please enter your height in m: ")
    ]);

    // Initialise the hashmap to store the user's data
    let mut data_map = std::collections::HashMap::<&str, f64>::new();

    // Iterates over the prompt mapping
    for (variable, prompt) in prompt_mapping {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("{prompt}");

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Adds the user's input to the data mapping
                    data_map.insert(variable, value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Get the weight and the height from the data map
    let weight = *data_map.get("weight").unwrap();
    let height = *data_map.get("height").unwrap();

    // Calculate the person's BMI
    let bmi = weight / (height.powi(2));

    // Prints the person's BMI
    println!("Your BMI is {bmi}");
}


// Function to calculate the time taken for a marathon
fn calculate_time_for_marathon() {

    // Get the time for the first 12 km
    let first_12_km_time_in_hr = 12.0 / 15.0;

    // Get the time for the next 15 km
    let next_15_km_time_in_hr = 15.0 / 10.0;

    // Get the time for the following 10 km
    let following_10_km_time_in_hr = 10.0 / 14.0;

    // Get the time for the last stretch
    let last_stretch_time_in_hr = (42.2 - 12.0 - 15.0 - 10.0) / 18.0;

    // Get the total time
    let total_time_in_hr = first_12_km_time_in_hr + next_15_km_time_in_hr
        + following_10_km_time_in_hr + last_stretch_time_in_hr;

    // Print the total time taken
    println!("The runner took {total_time_in_hr}hrs.")
}


// The function to read in a value
// and print it as an integer, float and string
fn read_and_print_input() {

    // Initialise the user input variable
    let mut user_input: f64 = 0.0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Print the prompt
        print!("Please enter a number: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Set the user_input variable to the value
                user_input = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Get the user's input as an integer and as a string
    let integer_input = user_input as i64;
    let string_input = user_input.to_string();

    // Print the result as the different data types
    println!("The integer value is {integer_input}");
    println!("The floating point value is {user_input}");
    println!("The string value is {string_input}");
}


// Function to evaluate a fourth degree polynomial of the form:
// ax4 + bx3 + cx2 + dx + e
fn evaluate_fourth_degree_polynomial() {

    // The list of terms
    let terms = ["x^4", "x^3", "x^2", "x", "constant"];

    // Initialise the hashmap to store the variables
    let mut data = std::collections::HashMap::<&str, f64>::new();

    // Iterates over the list of terms
    for term in terms {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("Please enter the coefficient for the {term} term: ");

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Adds the user's input to the hashmap
                    data.insert(term, value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Initialise the variable to store the user's input
    let mut user_input = 0.0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Print the prompt
        print!("Please enter the value for x: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Set the user's input
                user_input = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Gets all the variables
    let a = data.get("x^4").unwrap();
    let b = data.get("x^3").unwrap();
    let c = data.get("x^2").unwrap();
    let d = data.get("x").unwrap();
    let e = data.get("constant").unwrap();
    let x = user_input;

    // Calculate the result
    let result = a * x.powi(4) + b * x.powi(3) + c * x.powi(2) + d * x + e;

    // Prints the result
    println!("{}", result);
}


// Function to bet against a dice
fn bet_against_a_dice() {

    // Use the random crate to generate a random number between 1 and 6
    // The last number is not included so 7 is used instead of 6
    let random_number = rand::thread_rng().gen_range(1..=6);

    // Initialise the variable to store the user's input
    let mut user_input = 0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Print to tell the user what this is about
        println!(
            "Please enter a number between 1 and 6 to bet against the dice"
        );

        // Prints the prompt
        print!("Your bet: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<i64>() {

            // If there are no errors
            Ok(value) => {

                // If the user's input is between 1 and 6 inclusive,
                if value >= 1 && value <= 6 {

                    // Set the user's input
                    user_input = value;

                    // Set the is_number variable to true
                    is_number = true;
                }
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Get wheter or not the given number is equal to the random number
    let win = user_input == random_number;

    // Prints whether the user has won
    println!(
        "The dice value is {random_number}. You {}.",
        if win { "win" } else { "lose" }
    );
}


// Function to print a readable day string
// from a floating point number of days
fn print_readable_day_string() {

    // Initialise the variable to store the user's input
    let mut user_input = 0.0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!("Please enter the number of days as a decimal: ");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Set the user's input
                user_input = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Gets the number of days from the user input
    let number_of_days = user_input;

    // The list of functions to get the hours, minutes and seconds
    let function_list = [
        | x: f64 | x * 24.0,
        | x: f64 | x * 60.0,
        | x: f64 | x * 60.0
    ];

    // The list to store the data
    let mut data = Vec::<f64>::new();

    // Initialise the temporary variable to store the number of days
    let mut temp_number = number_of_days;

    // Iterates over the function list
    for function in function_list {

        // Gets the integer from the floating point number
        let int_number = temp_number as i64;

        // Adds the integer number to the list
        data.push(int_number as f64);

        // Subtract the integer from the floating point number
        // to get the decimal portion
        let decimal_portion = temp_number - int_number as f64;

        // Use the function to get the next part of the date
        // using the decimal portion
        temp_number = function(decimal_portion);
    }

    // Add the last number to the list
    data.push(temp_number);

    // Print the readable date string
    println!(
        "{} days = {} days {} hours {} mins and {} secs",
        number_of_days,
        data.get(0).unwrap(),
        data.get(1).unwrap(),
        data.get(2).unwrap(),
        data.get(3).unwrap()
    );
}


// Function to calculate the angles of a triangle,
// given the length of the 3 sides
fn calculate_triangle_angles() {

    // The list of variables to store the length
    // of the 3 sides of the triangle
    let variables = ["a", "b", "c"];

    // The data hashmap to store the user's input
    let mut data = std::collections::HashMap::<&str, f64>::new();

    // Iterates over the variables
    for variable in variables {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Prints the prompt
            print!(
                "Please enter the length of the side {variable} of the triangle: "
            );

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Add the user's input to the hashmap
                    data.insert(variable, value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Gets the variables from the data hashmap
    let a = *data.get("a").unwrap();
    let b = *data.get("b").unwrap();
    let c = *data.get("c").unwrap();

    // Calculate the angle of the sides
    let angle_a = ((b.powi(2) + c.powi(2) - a.powi(2)) / (2.0 * b * c)).acos();
    let angle_b = ((a.powi(2) + c.powi(2) - b.powi(2)) / (2.0 * a * c)).acos();
    let angle_c = ((a.powi(2) + b.powi(2) - c.powi(2)) / (2.0 * a * b)).acos();

    // Prints the angles
    println!("Angle opposite side a in radians is: {angle_a}");
    println!("Angle opposite side b in radians is: {angle_b}");
    println!("Angle opposite side c in radians is: {angle_c}");
}


// Function to print a bunch of variables
fn print_bunch_of_variables() {

    // Initialise the variables
    let a = 0.1;
    let b = a + a;
    let c = a + a + a;

    // Print the variables
    println!("a is {a}");
    println!("b is {b}");
    println!("c is {c}");
}


// The function to print the largest of 3 numbers
fn print_the_largest_of_3_numbers(a: f32, b: f32, c: f32) {

    // Creates a list from the 3 numbers
    let numbers = [a, b, c];

    // Initialise the largest number to the first number
    let mut largest_number = a;

    // Iterate over the list of numbers,
    // skipping the first number
    for &number in numbers[1..].iter() {

        // Check if the current number is larger than the largest number
        if number > largest_number {

            // Set the largest number to the current number
            largest_number = number;
        }
    }

    // Print the largest number
    println!("The largest number is {largest_number}");
}


// Function to check if an applicant qualifies for NTU
fn qualifies_for_ntu(academic_score: i32, aptitude_grade: &str) -> bool {

    // The variables to store whether an applicant qualifies for NTU
    let is_qualified = academic_score >= 75 &&
        ["A", "B", "C"].contains(&aptitude_grade) ||
        academic_score >= 60 && aptitude_grade == "A";

    // Returns the is qualified variable
    return is_qualified;
}


// Function that takes the number of hours worked in one month
// and then prints the gross pay, taxes and net pay.
fn print_pay_and_taxes() {

    // Initialise the basic pay rate
    const BASIC_PAY_RATE: f64 = 10.0;

    // Initialise the tax rate on the final remaining amount, which is 30%
    const REMAINING_AMOUNT_TAX_RATE: f64 = 0.3;

    // Initialise the user input variable
    let mut number_of_hours_worked = 0.0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!(
            "Please enter the number of hours worked in a month: "
        );

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Set the number of hours worked to the value
                number_of_hours_worked = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Gets the gross pay
    let mut gross_pay = BASIC_PAY_RATE * number_of_hours_worked;

    // Checks if the number of hours is above 160
    if number_of_hours_worked > 160.0 {

        // Sets the gross pay to 1.5 times the current gross pay
        gross_pay = 1.5 * gross_pay;
    }

    // Initialise the tax
    let mut tax = 0.0;

    // The hashmap to store the tax rates
    let tax_rates = std::collections::HashMap::from([
        (1000, 0.1),
        (500, 0.2),
    ]);

    // Initialise the remaining amount to the gross pay
    let mut remaining_amount = gross_pay;

    // Iterates over the tax rates
    for (tax_amount, tax_rate) in tax_rates {

        // Initialise the initial remaining amount
        // from the previous iteration of the loop
        let initial_remaining_amount = remaining_amount;

        // Subtract the tax amount from the remaining amount
        remaining_amount = remaining_amount - tax_amount as f64;

        // If the remaining amount is negative
        if remaining_amount < 0.0 {

            // Add to the tax with the current tax rate
            // multipled by the initial remaining amount
            tax += initial_remaining_amount * tax_rate;

            // Break the loop
            break;
        }

        // Otherwise, add the tax multiplied by the tax amount
        tax += tax_amount as f64 * tax_rate;
    }

    // If there's any amount remaining
    if remaining_amount > 0.0 {

        // Add the tax on that remaining amount
        tax += REMAINING_AMOUNT_TAX_RATE * remaining_amount;
    }

    // Gets the net pay
    let net_pay = gross_pay - tax;

    // Prints the gross pay, taxes and net pay
    println!("Gross pay: {gross_pay}");
    println!("Taxes: {tax}");
    println!("Net pay: {net_pay}");
}


// Function to get the numerical range of 3 given numbers
fn get_numerical_range(a: f32, b: f32, c: f32) {

    // Initalise the list of numbers
    let numbers = [a, b, c];

    // Initialise the largest and smallest number to the first number
    let mut largest_number = a;
    let mut smallest_number = a;

    // Iterates over th list of numbers,
    // skipping the first number
    for &number in numbers[1..].iter() {

        // Check if the current number is greater than the largest number
        if number > largest_number {

            // Set the largest number to the current number
            largest_number = number;
        }

        // Check if the current number is smaller than the smallest number
        if number < smallest_number {

            // Set the smallest number to the current number
            smallest_number = number;
        }
    }

    // Get the numerical range
    // which is the largest number - smallest number
    let numerical_range = largest_number - smallest_number;

    // Print the numerical range
    println!("Numerical range: {numerical_range}");
}


// Function to compare 2 birthdays and report who is older
fn compare_birthdays() {

    // Initialise the dictionary to store the data
    let mut data_dict: std::collections::HashMap<&str, Vec<i32>> =
        std::collections::HashMap::from([
            ("first person", vec![]),
            ("second person", vec![])
        ]);

    // Parts of the birthday
    let birthday_parts = ["day", "month", "year"];

    // Iterates over the data dictionary
    for (person, data_list) in &mut data_dict {

        // Tells the user to input the birthday for the person
        println!("Enter the {person}'s birthday");

        // Iterates over the parts of the birthday
        for part in birthday_parts {

            // Initialise the variable to represent
            // whether or not the input is numeric
            let mut is_number = false;

            // Initialise the string to store the user's input
            let mut input = String::new();

            // While the input is not numeric
            while !is_number {

                // Prints the prompt
                print!(
                    "Please enter the {part} of the birthday as an integer: "
                );

                // Flush the stdout
                std::io::stdout().flush().unwrap();

                // Read the user's input to the input variable
                match std::io::stdin().read_line(&mut input) {
                    Ok(_number_of_bytes) => (),
                    Err(error) => println!("Error: {error}")
                }

                // Match statement to handle errors
                match input.trim().parse::<i32>() {

                    // If there are no errors
                    Ok(value) => {

                        // Adds the value to the list
                        data_list.push(value);

                        // Set the is_number variable to true
                        is_number = true;
                    },

                    // If there's an error parsing, set is_number is false
                    Err(_) => is_number = false
                }

                // Make the input an empty string
                input = "".to_string();
            }
        }
    }

    // Gets the first birthday and reverse the list
    // so it's (year, month, day)
    let first_birthday: Vec<&i32> = data_dict.get("first person")
        .unwrap()
        .into_iter()
        .rev()
        .collect();

    // Gets the second birthday and reverse the list
    // so it's (year, month, day)
    let second_birthday: Vec<&i32> = data_dict.get("second person")
        .unwrap()
        .into_iter()
        .rev()
        .collect();

    // Check if the first birthday is equal to the second birthday
    if first_birthday == second_birthday {

        // Print that both people have the same birthday
        println!("Both individuals have the same birthday.");
    }

    // Otherwise, check if the first birthday is later than the second birthday
    else if first_birthday > second_birthday {

        // Print that the second person is older
        println!("The second person is older.")
    }

    // Otherwise
    else {

        // Print that the first person is older
        println!("The first person is older.")
    }
}


// Function to take a year and print if the year is a leap year
fn print_is_leap_year() {

    // Initialise the year variable
    let mut year = 0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!(
            "Please enter a year: "
        );

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<i32>() {

            // If there are no errors
            Ok(value) => {

                // Sets the year to the user's input
                year = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Set the variable is_leap_year.
    // The right hand side is the boolean expression.
    let is_leap_year = year % 4 == 0 && !(year % 100 == 0) || year % 400 == 0;

    // If the year is a leap year
    if is_leap_year {

        // Print "Leap year"
        println!("Leap year");
    }

    // Otherwise
    else {

        // Print "Not leap year"
        println!("Not leap year");
    }
}


// Function to take an integer and print the integer as a day string
fn print_day_from_integer_value() {

    // The dictionary mapping the day integer to the string
    let day_dict = std::collections::HashMap::from([
        (1, "Monday"),
        (2, "Tuesday"),
        (3, "Wednesday"),
        (4, "Thursday"),
        (5, "Friday"),
        (6, "Saturday"),
        (7, "Sunday")
    ]);

    // Initialise the day variable
    let mut day = 0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!(
            "Please enter an integer representing a day: "
        );

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<i32>() {

            // If there are no errors
            Ok(value) => {

                // Sets the year to the user's input
                day = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Gets the day string from the dictionary and
    // prints a result based on whether the day string is found or not
    match day_dict.get(&day) {
        Some(value) => println!("{}", value),
        None => println!("Illegal input")
    }
}


// Function to get the quadrant from an (x, y) coordinate
fn find_quadrant_of_coordinates() {

    // The list to store the user's input for the x and y coordinates
    let mut x_y_coordinates: Vec<f64> = vec![];

    // Iterates over the list of axes
    for axis in ["x", "y"] {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Prints the prompt
            print!(
                "Please enter the {axis} coordinate: "
            );

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Adds the user's input to the list of coordinates
                    x_y_coordinates.push(value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Gets the x and y values
    let x = x_y_coordinates[0];
    let y = x_y_coordinates[1];

    // Check if the x && y values are in the first quadrant
    if x > 0.0 && y > 0.0 {

        // Print that the coordinates are in the first quadrant
        println!("The coordinates are in the first quadrant.");
    }

    // Otherwise, check if the x && y values are in the second quadrant
    else if x < 0.0 && y > 0.0 {

        // Print that the coordinates are in the second quadrant
        println!("The coordinates are in the second quadrant.");
    }

    // Otherwise, check if the x && y values are in the third quadrant
    else if x < 0.0 && y < 0.0 {

        // Print that the coordinates are in the third quadrant
        println!("The coordinates are in the third quadrant.");
    }

    // Otherwise, check if the x && y values are in the fourth quadrant
    else if x > 0.0 && y < 0.0 {

        // Print that the coordinates are in the fourth quadrant
        println!("The coordinates are in the fourth quadrant.");
    }

    // Otherwise, check if the x value is 0
    else if x as i32 == 0 {

        // Print that the coordinates are on the x-axis
        println!("The coordinates are on the x-axis.");
    }

    // Otherwise, check if the y value is 0
    else if x as i32 == 0 {

        // Print that the coordinates are on the x-axis
        println!("The coordinates are on the y-axis.");
    }
}


// Function to print the numbers 1 to 12 on one line
// and the numbers 13 to 24 on another line
fn print_numbers(join_string: &str) {

    // Initialise the list to print the first line
    let mut first_line: Vec<String> = vec![];

    // Initialise the list to print the second line
    let mut second_line: Vec<String> = vec![];

    // Iterates over all the number
    for number in 0..=24 {

        // If the number is less than or equal to 12
        if number <= 12 {

            // Adds the number to the first line
            first_line.push(number.to_string());
        }

        // Otherwise
        else {

            // Adds the number to the second line
            second_line.push(number.to_string());
        }
    }

    // Prints the first and second line with the numbers
    // joined by the joining string
    println!("{}", first_line.join(join_string));
    println!("{}", second_line.join(join_string));
}


// Function that iterates from 1 to the given X value
// and prints the numbers that X is divisible by.
fn rewrite_for_loop_as_while_loop(X: i32) {

    // Initialise i as 0
    let mut i = 0;

    // Iterate over the numbers from 0 till X
    while i < X + 1 {

        // Increment i by 1
        i += 1;

        // If X is divisible by the current number
        if X % i == 0 {

            // Prints the current number
            println!("{i}");
        }
    }
}


// Function to calculate the sum of the mathematical expression below:
// from i = 1 to n, sum (1/i + 1)
fn mathematical_sum_1(n: i32) -> f32 {

    // Initialise the sum variable to 0
    let mut sum = 0.0;

    // Iterates from 1 to n
    for i in 1..=n {

        // Adds 1/i + 1 to the sum
        sum += 1.0/(i as f32) + 1.0;
    }

    // Return the sum
    return sum;
}


// Function to calculate the sum of the mathematical expression below:
// from i = 1 to n, sum (i + (from j = 0 to i, sum j))
fn mathematical_sum_2(n: i32) -> i32 {

    // Initialise the sum variable to 0
    let mut sum = 0;

    // Iterates from 1 to n
    for i in 1..=n {

        // Add the current number to the sum
        sum += i;

        // Iterates from 0 to the current number i
        for j in 0..=i {

            // Add the current number j to the sum
            sum += j;
        }
    }

    // Returns the sum
    return sum;
}


// Function to print all the numbers less than 1000
// that are divisible by 29
fn print_numbers_less_than_1000_divisible_by_29() {

    // The list of strings to store the numbers to print
    let mut str_list: Vec<String> = vec![];

    // Iterates from 0 to 999
    for number in 0..1000 {

        // Checks if the number is divisible by 29
        if number % 29 == 0 {

            // Adds the number as a string to the string list
            str_list.push(number.to_string());
        }
    }

    // Print the list of numbers
    println!("{}", str_list.join("\n"));
}


// Function to calculate euler's number to a given number of decimal places
fn calculate_eulers_number(number_of_decimal_places: i32) -> f64 {

    // Initialise euler's number
    let mut eulers_number = 0.0;

    // Initialise the i variable
    let mut i = 0;

    // Starts an infinite loop
    loop {

        // Gets the current term
        let term = 1.0 / (((1..=i).product::<u64>()) as f64);

        // If the value of the current term is less than
        // 10 to the power of the negative of the number of decimal places
        if term.abs() < f64::powi(10.0, -number_of_decimal_places) {

            // Break out of the loop
            break;
        }

        // Otherwise, add the term to euler's number
        eulers_number += term;

        // Increase i by 1
        i += 1;
    }

    // Return euler's number rounded to the number of decimal places needed
    return (
        eulers_number * f64::powi(10.0, number_of_decimal_places)
    ).round() / f64::powi(10.0, number_of_decimal_places);
}


// Function to print all the leap years between a start and end year
fn print_leap_years_between(start_year: i32, end_year: i32) {

    // Initialise the list of strings to print
    let mut str_list: Vec<String> = vec![];

    // Iterates over all the years from the start to the end year
    for year in start_year..=end_year {

        // Get whether the year is a leap year or not
        let is_leap_year = year % 4 == 0 && !(year % 100 == 0) ||
            year % 400 == 0;

        // If the year is a leap year
        if is_leap_year {

            // Add the year to the list as a string
            str_list.push(year.to_string());
        }
    }

    // Split the list of strings into groups of 8

    // Gets the length of the list of strings
    let str_list_len = str_list.len();

    // Get the number of groups of 8
    let number_of_groups = str_list_len / 8;

    // Iterates over the number of groups
    for group_number in 1..=number_of_groups {

        // Gets the slice of the string list that is a group of 8
        let str_list_slice = &str_list[
            (group_number - 1) * 8 .. group_number * 8
        ];

        // Prints the slice joined with a comma and a space
        println!("{}", str_list_slice.join(", "));
    }

    // Get the remaining years
    let remaining_years = &str_list[number_of_groups * 8..];

    // Print the remaining years
    println!("{}", remaining_years.join(", "));
}


// Function to generate the SGD to RM and RM to SGD conversion tables
fn generate_sgd_rm_conversion_tables() {

    // THe conversion rate
    const SGD_TO_RM_CONVERSION_RATE: f32 = 3.03;

    // The list to store the user's input
    let mut data: Vec<i32> = vec![];

    // The list of prompts
    let prompts = ["start", "end", "increment (step)"];

    // Iterates over the prompts
    for prompt in prompts {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Prints the prompt
            print!(
                "Please enter the {prompt} value: "
            );

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<i32>() {

                // If there are no errors
                Ok(value) => {

                    // Adds the user's input to the list
                    data.push(value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Initialise the list of strings to print
    let mut str_list: Vec<String> = vec!["SGD to RM Table".to_string()];

    // Initialise the values to the values given by the user
    let start_value = data[0];
    let end_value = data[1];
    let increment = data[2];

    // Iterates from the start to the end value with an increment,
    // all of which are given by the user
    for dollar_amount in
        (start_value..=end_value).step_by(increment as usize) {

        // Convert the dollar amount to RM
        let dollar_amount_in_rm =
            SGD_TO_RM_CONVERSION_RATE * dollar_amount as f32;

        // Adds the information to the string list to be printed
        str_list.push(
            format!("S${dollar_amount} : RM{dollar_amount_in_rm}")
        );
    }

    // Add an empty string to the string list
    // This will be a double newline so there's some spacing between
    // the SGD to RM table and the RM to SGD table
    str_list.push("".to_string());

    // Add the header for the RM to SGD table
    str_list.push("RM to SGD table".to_string());

    // Initialise the RM amount to the start value
    let mut rm_amount = start_value;

    // Iterates while the RM amount is less than the end value
    while rm_amount <= end_value {

        // Get the dollar amount from the amount in RM
        let rm_amount_in_dollar = rm_amount as f32 / SGD_TO_RM_CONVERSION_RATE;

        // Adds the information to the string list to be printed
        str_list.push(format!("RM{rm_amount} : S${rm_amount_in_dollar}"));

        // Increase the RM amount by the increment
        rm_amount += increment;
    }

    // Prints the list of strings joined with a new line character
    println!("{}", str_list.join("\n"));
}


// Function to take a height from a user a print a triangular pattern
// of AAs and BBs.
fn print_trianglular_pattern_of_lines() {

    // Initialise the variable to store the height of the triangular pattern
    let mut height = 0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!(
            "Please enter the height of the triangular pattern: "
        );

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<i32>() {

            // If there are no errors
            Ok(value) => {

                // Sets the height to the user's input
                height = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // The list of strings to print
    let mut str_list: Vec<String> = vec![];

    // Iterates until the height given
    for i in 1..=height {

        // Gets the quotient of the number divided by 2
        let quotient = i / 2;

        // Gets the remainder of the number divided by 2
        let remainder = i % 2;

        // Gets the string at the start
        let start_string = if remainder == 1 { "AA" } else { "" };

        // Creates the string and add it to the list
        str_list.push(
            format!("{start_string}{}", "BBAA".repeat(quotient as usize))
        );
    }

    // Prints the triangular pattern
    println!("{}", str_list.join("\n"));
}


// Function to print every alternate character starting from the second
fn print_every_alternate_character() {

    // Gets the string
    let string = "Introduction to Computational Thinking";

    // Gets the list of characters from the string
    let char_list: Vec<char> = string.chars().collect();

    // Initialise the list of characters for the final string
    let mut final_char_list: Vec<char> = vec![];

    // Iterates over the characters of the list,
    // starting from the second character
    for i in (1..char_list.len()).step_by(2) {

        // Add the current character to the final list of characters
        final_char_list.push(char_list[i]);
    }

    // Get the string from the final list of characters
    let final_string: String = final_char_list.iter().collect();

    // Print the final string
    println!("{}", final_string);
}


// The function to prompt the user for a string and print the ASCII value of
// each character in the string
fn prompt_string_and_print_ascii() {

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a string: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // The list of ASCII values
    let ascii_values: Vec<String> = input.trim().chars()
        .map(|char| (char as u8).to_string())
        .collect();

    // Prints the ASCII values
    println!("{}", ascii_values.join(" "));
}


// Function to print the multiplication table form 1 to 12
fn print_multiplication_table() {

    // Initialise the list of strings to print
    let mut str_list: Vec<String> = vec![];

    // The number range
    let number_range = 1..=12;

    // Iterates over the numbers
    for first_number in number_range.clone() {

        // Adds an empty string to the list for a new line
        str_list.push("".to_string());

        // Add the header for the multiplication table
        str_list.push(format!("Multiplication table for {first_number}"));

        // Iterates over the number range again
        for second_number in number_range.clone() {

            // Gets the result of the multiplication
            let result = first_number * second_number;

            // Adds the multiplication to the list
            str_list.push(
                format!("{first_number} x {second_number} = {result}")
            );
        }
    }

    // Prints the multiplication table joined by new lines
    println!("{}", str_list.join("\n"));
}


// Function to check if all the vowels are present in the string
fn all_vowels_present(string: &str) -> bool {

    // The set of all vowels
    let vowels = std::collections::HashSet::from(['a', 'e', 'i', 'o', 'u']);

    // Initialise an empty set to store the vowels in the string
    let mut vowels_in_str = std::collections::HashSet::<char>::new();

    // Iterates over the characters in the string
    for char in string.chars() {

        // If the current character is a vowel
        if vowels.contains(&char.to_ascii_lowercase()) {

            // Add the character to the set of vowels in the string
            vowels_in_str.insert(char);
        }
    }

    // Returns if the set of vowels in the string has the same length
    // as the set of vowels
    return vowels_in_str.len() == vowels.len();
}


// Function to print out the number of words, upper case letters,
// lower case letters, digits and other characters.
fn print_sentence_stats() {

    // Initialise all the variables to store the information required
    let mut number_of_words = 0;
    let mut number_of_uppercase = 0;
    let mut number_of_lowercase = 0;
    let mut number_of_digits = 0;
    let mut number_of_other_chars = 0;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a sentence: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Iterate over all the characters of the string
    for char in input.trim().chars() {

        // Check if the character is an uppercase letter
        if char.is_uppercase() {

            // Increment the uppercase letter count by 1
            number_of_uppercase += 1;
        }

        // Otherwise, check if the character is a lowercase letter
        else if char.is_lowercase() {

            // Increment the lowercase letter count by 1
            number_of_lowercase += 1;
        }

        // Otherwise, check if the character is a digit
        else if char.is_digit(10) {

            // Increment the digit count by 1
            number_of_digits += 1;
        }

        // Otherwise
        else {

            // Increment the count of the other characters by 1
            number_of_other_chars += 1;

            // Check if the character is a space character
            if char.is_whitespace() {

                // Increment the word count
                number_of_words += 1;
            }
        }
    }

    // If the number of words is not zero, increment its count by 1
    // This is because the number of spaces is always 1 less than the number
    // of words, due to the spaces being the separator between words.
    number_of_words = if number_of_words != 0 {
        number_of_words + 1
    } else { 0 };

    // The list of strings to print out
    let str_list = [
        format!("Number of words: {number_of_words}"),
        format!("Number of uppercase letters: {number_of_uppercase}"),
        format!("Number of lowercase letters: {number_of_lowercase}"),
        format!("Number of digits: {number_of_digits}"),
        format!("Number of other characters: {number_of_other_chars}"),
    ];

    // Print the list of strings joined by a new line character
    println!("{}", str_list.join("\n"));
}


// A function to ask the user for a string and encrypt it
fn encrypt_given_string() {

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a sentence: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Initialise the list of characters
    let mut list_of_chars: Vec<char> = vec![];

    // Iterates over the user's input
    for char in input.trim().chars() {

        // If the character is not a digit or a letter
        if !char.is_alphanumeric() {

            // Add the character to the list of characters
            list_of_chars.push(char);

            // Continue the loop
            continue;
        }

        // Otherwise, initialise the new character to
        // add to the list of characters
        let mut new_char: char;

        // Otherwise, check if the character is uppercase
        if char.is_uppercase() {

            // Gets the number of the encrypted character
            // 65 is because uppercase A is 65,
            // so subtracting 64 will make uppercase A 0
            let new_ordinal = (char as u8 - 65 + 5) % 26 + 65;

            // Set the new character
            new_char = new_ordinal as char;
        }

        // Otherwise, check if the character is lowercase
        else if char.is_lowercase() {

            // Gets the number of the encrypted character
            // 97 is because lowercase a is 97,
            // so subtracting 97 will make lowercase a 0
            let new_ordinal = (char as u8 - 97 + 5) % 26 + 97;

            // Set the new character
            new_char = new_ordinal as char;
        }

        // Otherwise, the character is a digit
        else {

            // Gets the number of the encrypted digit
            let new_number = (char.to_digit(10).unwrap() + 3) % 9;

            // Set the new character
            new_char = char::from_digit(new_number, 10).unwrap();
        }

        // Add the new character to the list of characters
        list_of_chars.push(new_char);
    }

    // Prints the encrypted string
    println!("{}", list_of_chars.iter().collect::<String>());
}


// A function to print 'valid' if the given string is a valid Python variable
// nam and 'invalid' otherwise.
fn is_valid_python_variable() {

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a variable name: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Trims the user input
    let user_input = input.trim();

    // If the user's input is empty, print "Invalid" and exit the function
    if user_input.len() == 0 {
        return println!("Invalid");
    }

    // The list of ordinals for the numbers
    let mut number_ordinals: Vec<u8> = (('0' as u8)..=('9' as u8)).collect();

    // The list of ordinals for the alphabets
    let mut alphabet_ordinals: Vec<u8> = (('A' as u8)..=('z' as u8)).collect();

    // Append the number ordinals to the alphabet ones
    alphabet_ordinals.append(&mut number_ordinals);

    // Add the ordinal for the underscore to the list of ordinals
    alphabet_ordinals.push('_' as u8);

    // Create a set containing the ordinals of all the accepted characters
    let valid_char_ordinals = std::collections::HashSet::<u8>::from_iter(
        alphabet_ordinals
    );

    // Gets the first character of the user's input
    let first_char = user_input.chars().nth(0).unwrap();

    // If the first character of the string is a digit or special character,
    // print "Invalid" and exit the function
    if first_char.is_digit(10) || !valid_char_ordinals.contains(
        &(first_char as u8)
    ) {
        return println!("Invalid");
    }

    // Otherwise, iterate over the string
    for char in user_input.chars() {

        // If the ordinal of the character isn't
        // in the set of valid characters,
        // print "Invalid" and exit the function
        if !valid_char_ordinals.contains(&(char as u8)) {
            return println!("Invalid");
        }
    }

    // Print "Valid"
    println!("Valid");
}


// The function to calculate the circumference and the area of a circle,
// given the radius.
fn calculate_circumference_and_area_of_circle() {

    // Initialise the radius variable to store the radius of the circle
    let mut radius = 0.0;

    // Initialise the variable to represent
    // whether or not the input is numeric
    let mut is_number = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // While the input is not numeric
    while !is_number {

        // Prints the prompt
        print!(
            "Please enter the radius of the circle: "
        );

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Match statement to handle errors
        match input.trim().parse::<f64>() {

            // If there are no errors
            Ok(value) => {

                // Sets the height to the user's input
                radius = value;

                // Set the is_number variable to true
                is_number = true;
            },

            // If there's an error parsing, set is_number is false
            Err(_) => is_number = false
        }

        // Make the input an empty string
        input = "".to_string();
    }

    // Calculate the circumference and the radius of the circle
    let circumference = 2.0 * std::f64::consts::PI * radius;
    let area = 2.0 * std::f64::consts::PI * radius.powi(2);

    // Print the calculations
    println!(
        "Radius of circle = {:.2}, circumference = {:.2}, area = {:.2}",
        radius, circumference, area
    );
}


// A function to print 'valid' if the given string is a valid Python variable
// name and 'invalid' otherwise. This accounts for Python keywords and gives
// a reason for the variable name being invalid.
fn is_valid_python_variable_with_keywords_and_reason() {

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a variable name: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Trims the user input
    let user_input = input.trim();

    // If the user's input is empty, print "Invalid" and exit the function
    if user_input.len() == 0 {
        return println!("Invalid. Reason: Empty string.");
    }

    // The set of Python keywords
    let python_keywords = std::collections::HashSet::from([
        "and",
        "as",
        "assert",
        "break",
        "class",
        "continue",
        "def",
        "del",
        "elif",
        "else",
        "except",
        "False",
        "finally",
        "for",
        "from",
        "global",
        "if",
        "import",
        "in",
        "is",
        "lambda",
        "None",
        "nonlocal",
        "not",
        "or",
        "pass",
        "raise",
        "return",
        "True",
        "try",
        "while",
        "with",
        "yield",
    ]);

    // If the user's input is a keyword, print "Invalid" and the reason
    // and exit the function
    if python_keywords.contains(user_input) {
        return println!("Invalid. Reason: The name is a Python keyword.")
    }

    // The list of ordinals for the numbers
    let mut number_ordinals: Vec<u8> = (('0' as u8)..=('9' as u8)).collect();

    // The list of ordinals for the alphabets
    let mut alphabet_ordinals: Vec<u8> = (('A' as u8)..=('z' as u8)).collect();

    // Append the number ordinals to the alphabet ones
    alphabet_ordinals.append(&mut number_ordinals);

    // Add the ordinal for the underscore to the list of ordinals
    alphabet_ordinals.push('_' as u8);

    // Create a set containing the ordinals of all the accepted characters
    let valid_char_ordinals = std::collections::HashSet::<u8>::from_iter(
        alphabet_ordinals
    );

    // Gets the first character of the user's input
    let first_char = user_input.chars().nth(0).unwrap();

    // If the first character of the string is a digit
    // print "Invalid" and the reason and exit the function
    if first_char.is_digit(10) {
        return println!(
            "Invalid. Reason: Python variables cannot start with numbers."
        );
    }

    // Otherwise, iterate over the string
    for char in user_input.chars() {

        // If the ordinal of the character isn't
        // in the set of valid characters,
        // print "Invalid" and exit the function
        if !valid_char_ordinals.contains(&(char as u8)) {
            return println!(
                "Invalid. Reason: {char} is not allowed in Python variable names."
            );
        }
    }

    // Print "Valid"
    println!("Valid");
}


// Function to print a list of list as a matrix
// It also prints its transpose
fn print_list_of_numbers_as_matrix(list_of_list: Vec<Vec<i32>>) {

    // THe list of strings to print for the matrix
    let mut matrix_str_list: Vec<String> = vec![];

    // The list of strings to print for the matrix transpose
    let mut transpose_str_list: Vec<Vec<String>> = (0..list_of_list.len())
        .map(|_| vec![])
        .collect();

    // Iterates over the list
    for row in list_of_list {

        // Initialise the list of strings for the row
        let mut row_str_list: Vec<String> = vec![];

        // Iterates over the numbers in the row
        for (index, number) in row.iter().enumerate() {

            // Add the number to the list of strings for the row
            row_str_list.push(number.to_string());

            // Add the number to the transpose at the index
            transpose_str_list[index].push(number.to_string());
        }

        // Add the row to the matrix string list joined by spaces
        matrix_str_list.push(row_str_list.join(" "));
    }

    // Prints the matrix
    println!("{}", matrix_str_list.join("\n"));

    // Prints a new line
    println!();

    // Print the transpose
    println!(
        "{}",
        transpose_str_list
            .iter()
            .map(|row| row.join(" "))
            .collect::<Vec<String>>()
            .join("\n")
    );
}


// Function to convert a date 'dd/mm/yyyy' to a list [dd, mm, yyyy]
fn convert_date_to_list(short_date: &str) -> Vec<i32> {
    return short_date.split("/")
        .map(|date_part| date_part.parse::<i32>().unwrap())
        .collect();
}


// Function to print the long date format 'dd Month, yyyy'
// from the short date format 'dd/mm/yyyy'
fn print_long_date(short_date: &str) {

    // The month dictionary
    let month_dict = std::collections::HashMap::from([
        (1, "January"),
        (2, "February"),
        (3, "March"),
        (4, "April"),
        (5, "May"),
        (6, "June"),
        (7, "July"),
        (8, "August"),
        (9, "September"),
        (10, "October"),
        (11, "November"),
        (12, "December"),
    ]);

    // Convert the date to a list and grab the date list
    let date_list = short_date.split("/")
        .map(|date_part| date_part.parse::<i32>().unwrap())
        .collect::<Vec<i32>>();

    // Gets the date, month and year from the date list
    let (date, month, year) = (date_list[0], date_list[1], date_list[2]);

    // Gets the long month from the month
    let long_month = month_dict.get(&month).unwrap();

    // Prints the date in the long date format
    println!("{date} {long_month}, {year}");
}


// Function to add two vectors together
fn add_two_vectors(vec_1: Vec<f64>, vec_2: Vec<f64>) -> Vec<f64> {

    // Returns the sum of the two vectors
    vec_1.iter().enumerate()
        .map(|(index, value)| value + vec_2[index])
        .collect()
}


// Function to get the dot product of two vectors
fn dot_product_vec(vec_1: Vec<i32>, vec_2: Vec<i32>) -> i32 {

    // Returns the dot product of the two vectors
    vec_1.iter().enumerate()
        .map(|(index, value)| value * vec_2[index])
        .sum()
}


// Function to print all the words in a given input, separated by new lines
fn print_words_of_a_given_input() {

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a sentence: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Trims the user input
    let user_input = input.trim();

    // The punctuation regex to find all the punctuation characters
    let punctuation_regex = Regex::new(r#"[.,?!;:'"()\[\]{}-]"#).unwrap();

    // Replace all the punctuations marks with a space
    let processed_input = punctuation_regex.replace_all(user_input, " ");

    // Iterates over all the words in the string split using spaces
    // and filter out all the empty strings
    for word in processed_input
        .split(" ")
            .filter(|string| !string.is_empty()) {

        // Print the word
        println!("{word}");
    }
}


// Function to print all the words in a given input, separated by new lines,
// but this time without using the str.split function
fn print_words_of_a_given_input_no_split() {

    // The set of all punctuation
    let punctuation_set: std::collections::HashSet<char> =
        std::collections::HashSet::from_iter(
        ".,?!;:'\"()[]{}-".chars()
    );

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Prints the prompt
    print!("Please enter a sentence: ");

    // Flush the stdout
    std::io::stdout().flush().unwrap();

    // Read the user's input to the input variable
    match std::io::stdin().read_line(&mut input) {
        Ok(_number_of_bytes) => (),
        Err(error) => println!("Error: {error}")
    }

    // Trims the user input
    let user_input = input.trim();

    // Get the length of the user's input
    let input_len = user_input.len();

    // The list of words to print
    let mut word_list: Vec<String> = vec![];

    // The variable to store the position of the last word
    let mut previous_word_index = 0;

    // Iterates over the characters in the input
    for (index, char) in user_input.chars().enumerate() {

        // If the character is punctuation or space
        if char.is_whitespace() || punctuation_set.contains(&char) {

            // Gets the word
            let word = &user_input[previous_word_index..index];

            // Adds the word to the list of words
            // if the word isn't an empty string
            if word.len() > 0 {
                word_list.push(word.trim().to_string())
            } else {};

            // Update the previous word index to the current index + 1
            // if the index is less than the length of the input
            previous_word_index = if index + 1 < input_len {
                index + 1
            } else { input_len - 1 };
        }
    }

    // Add the last word to the list
    word_list.push(
        user_input.chars().collect::<Vec<_>>()[previous_word_index..]
            .iter()
            .collect()
    );

    // Print the list of words joined with a new line character
    println!("{}", word_list.join("\n"));
}


// The function to return if a year is a leap year
fn is_leap_year(year: i32) -> bool {
    year % 4 == 0 && !(year % 100 == 0) || year % 400 == 0
}


// Function to read in 2 vectors and print their sum
fn print_sum_of_vectors() {

    // Initialise the list to store the vectors
    let mut vec_list: Vec<Vec<f64>> = vec![];

    // Iterates over the number of vectors, which is 2
    for vec_num in 1..=2 {

        // Initialise the vector
        let mut vector: Vec<f64> = vec![];

        // Iterates over the coordinates for the vector
        for nth_coord in 1..=2 {

            // Initialise the variable to represent
            // whether or not the input is numeric
            let mut is_number = false;

            // Initialise the string to store the user's input
            let mut input = String::new();

            // While the input is not numeric
            while !is_number {

                // Print the prompt
                print!("Please enter the {nth_coord} coordinate for vector {vec_num}: ");

                // Flush the stdout
                std::io::stdout().flush().unwrap();

                // Read the user's input to the input variable
                match std::io::stdin().read_line(&mut input) {
                    Ok(_number_of_bytes) => (),
                    Err(error) => println!("Error: {error}")
                }

                // Match statement to handle errors
                match input.trim().parse::<f64>() {

                    // If there are no errors
                    Ok(value) => {

                        // Add the value to the vector
                        vector.push(value);

                        // Set the is_number variable to true
                        is_number = true;
                    },

                    // If there's an error parsing, set is_number is false
                    Err(_) => is_number = false
                }

                // Make the input an empty string
                input = "".to_string();
            }
        }

        // Adds the vector to the list of vectors
        vec_list.push(vector);
    }

    // Adds the two vectors together and print the result
    println!("{:?}", add_two_vectors(
        (*vec_list[0]).to_vec(), (*vec_list[1]).to_vec())
    );
}


// A function to calculate the horizontal distance of projectile motion
// The velocity is the velocity of the projectile at launch.
// The height is the initial height of the projectile.
// The theta is the angle at which the projectile is launched in radians.
fn calculate_horizontal_distance_of_projectile_motion(
    velocity: f64,
    height: f64,
    angle: f64
) -> f64 {

    // Set the gravitational constant g
    let g = 9.81;

    // Gets the distance using the mathematical equation
    let distance = (velocity.powi(2) / (2.0 * g)) *
        (1.0 + (1.0 + (
            (2.0 * g * height) / (velocity.powi(2) * (angle.sin().powi(2)))
        )).powf(0.5)) * (angle * 2.0).sin();

    // Returns the distance
    distance
}


// A function to read the velocity, height and angle of projectile motion
// from the user and print the horizontal distance
fn print_horizontal_distance_of_projectile_motion() {

    // The list of variables
    let variable_list = ["velocity", "height", "angle in radians"];

    // The list to store the user's input
    let mut data: Vec<f64> = vec![];

    // Iterates over all the variables
    for variable in variable_list {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("Please enter the {variable} of projectile motion: ");

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<f64>() {

                // If there are no errors
                Ok(value) => {

                    // Add the value to the data
                    data.push(value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Calculate the horizontal distance
    let distance = calculate_horizontal_distance_of_projectile_motion(
        data[0], data[1], data[2]
    );

    // Prints the distance
    println!("The horizontal distance is {distance} m.");
}


// Function to simulate the rolling of a dice
fn roll_dice() -> i32 {

    // Use the random crate to generate a random number between 1 and 6
    rand::thread_rng().gen_range(1..=6)
}


// Function to sum 3 rolls of the dice, and return the sum.
// It also returns whether the 3 rolls are the same.
fn sum_of_three_rolls() -> (i32, bool) {

    // Gets the list of rolls
    let rolls: Vec<i32> = (1..=3).map(|_| roll_dice()).collect();

    // Gets the sums of the 3 rolls
    let sum_of_rolls = rolls.iter().sum::<i32>();

    // Gets whether the 3 rolls are equal
    let three_rolls_are_equal = rolls.iter().all(|roll| *roll == rolls[0]);

    // Returns the sum of the 3 rolls and whether the 3 rolls are equal
    (sum_of_rolls, three_rolls_are_equal)
}


// A function to play a dice game
// The function prints 'Jackpot' if all the dice rolls are the same,
// 'Big' if the sum of the dice rolls is 11 and above,
// 'Small' if the sum of the dice rolls is 10 and below
fn dice_game() {

    // Gets the sum of the 3 rolls and if the 3 rolls are equal
    let (sum_of_rolls, three_rolls_are_equal) = sum_of_three_rolls();

    // If the 3 rolls are equal
    if three_rolls_are_equal {

        // Print "Jackpot"
        println!("Jackpot");
    }

    // Otherwise, if the sum is greater or equal to 11
    else if sum_of_rolls >= 11 {

        // Print "Big"
        println!("Big");
    }

    // Otherwise
    else {

        // Print "Small"
        println!("Small");
    }
}


// Function to return the number of days that have passed
// since Januaray 1st 2023
fn number_of_days_from_jan_2023() {

    // The list of variables
    let variables = ["day of the month", "month"];

    // The list of the number of days in a specific month
    let num_of_days_in_month_list = [
        31,
        28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
    ];

    // The list to store the user's input
    let mut data: Vec<i32> = vec![];

    // Iterates over the variables
    for variable in variables {

        // Initialise the variable to represent
        // whether or not the input is numeric
        let mut is_number = false;

        // Initialise the string to store the user's input
        let mut input = String::new();

        // While the input is not numeric
        while !is_number {

            // Print the prompt
            print!("Enter the {variable}: ");

            // Flush the stdout
            std::io::stdout().flush().unwrap();

            // Read the user's input to the input variable
            match std::io::stdin().read_line(&mut input) {
                Ok(_number_of_bytes) => (),
                Err(error) => println!("Error: {error}")
            }

            // Match statement to handle errors
            match input.trim().parse::<i32>() {

                // If there are no errors
                Ok(value) => {

                    // Add the value to the data
                    data.push(value);

                    // Set the is_number variable to true
                    is_number = true;
                },

                // If there's an error parsing, set is_number is false
                Err(_) => is_number = false
            }

            // Make the input an empty string
            input = "".to_string();
        }
    }

    // Get the day of the month and the month
    let day_of_the_month = data[0];
    let month = data[1];

    // Get the number of days from the start of the year
    let num_of_days = &num_of_days_in_month_list[..(month - 1) as usize]
        .iter().sum::<i32>() + day_of_the_month;

    // Print the number of days elapsed
    println!(
        "{} {day_of_the_month}/{month}/2023 is {num_of_days}",
        "The number of days elapsed from 1/1/2023 to",
    )
}


// Function to add the income of a shopt to the revenue dictionary
fn add_income<'a>(
    revenue: &mut std::collections::HashMap<&'a str, f32>,
    shop: &'a str,
    income: f32
) {

    // If the shop is already inside the revenue dictionary,
    // add the shop's income to the revenue.
    // Otherwise, add the shop to the revenue dictionary.
    *revenue.entry(shop).or_insert(0.0) += income;
}


// A function to add multiple shops to the revenue dictionary
fn add_shops_to_revenue_dict() {

    // The revenue dictionary
    let mut revenue = std::collections::HashMap::from([
        ("Jurong", 1620.55),
        ("Bedok", 2598.60),
        ("Sengkang", 1886.40)
    ]);

    // Add the income of a shop called "Punggol"
    add_income(&mut revenue, "Punggol", 3000.0);

    // Add the income of a shop named "Tanjong Pagar"
    add_income(&mut revenue, "Tanjong Pagar", 42069.0);

    // Add the income of the Jurong shop
    add_income(&mut revenue, "Jurong", 6969.42069);

    // Print the revenue dictionary
    println!("{:?}", revenue);
}


// Function to check if the character at the given index is a digit.
fn check_digit(string: &str, index: usize) -> bool {

    // If the index is greater than the length of the string - 1,
    // return false immediately
    if index > string.len() {
        return false;
    }

    // Returns if the character at the given index is a digit
    string.chars().nth(index).unwrap().is_digit(10)
}


// Function to get the area of a shape
fn area(base_or_radius: f32, height: f32, shape: &str) -> f32 {

    // The dictionary mapping the shape to the area calculation
    let area_dict = std::collections::HashMap::from([
        ("cir", std::f32::consts::PI * (base_or_radius.powi(2))),
        ("rect", base_or_radius * height),
        ("tri", base_or_radius * height * (1.0 / 2.0))
    ]);

    // Returns the area caculation
    *area_dict.get(shape).unwrap()
}


// Function to insert an IC number and the coresponding birthday
// into the birthday dictionary
fn insert_into_birthday_dict(
    birthday_dict: &mut std::collections::HashMap<String, [String; 3]>,
    ic_number: &str,
    birthday_tuple: [String; 3]
) {

    // If the birthday dictionary doesn't already contain the IC number,
    // add the birthday to the dictionary
    if birthday_dict.contains_key(ic_number) {
        birthday_dict.insert(ic_number.to_string(), birthday_tuple);
    }
}


// Function to check if the IC number and the birthday matches up
// in the birthday dictionary.
// The function returns 1 if the IC number exists and the birthday is the
// same as the dictionary.
// The function returns 2 if the IC number doesn't exist.
// THe function returns 3 if the IC number exists but the birthday
// is different.
fn check_birthday_in_birthday_dict(
    birthday_dict: &mut std::collections::HashMap<String, [String; 3]>,
    ic_number: &str,
    birthday_tuple: [String; 3]
) -> i32 {

    // Gets the birthday tuple from the dictionary
    let stored_birthday_tuple = birthday_dict.get(ic_number);

    // Match statement to match the possible values of stored_birthday_tuple
    match stored_birthday_tuple {
        Some(value) => if birthday_tuple == *value { 1 } else { 3 }
        None => 2
    }
}


// Function to exchange money betweeh SGD and RM.
// amount is the amount of money to be exchanged.
// rate is the amount in RM for 1 SGD.
// mode is a boolean indicating whether the function should convert from
// SGD to RM or from RM to SGD.
fn exchange_amount(amount: f32, rate: f32, mode: bool) -> f32 {

    // Rename the mode to to_sgd
    let to_sgd = mode;

    // Returns the exchanged amount
    if to_sgd { amount / rate } else { amount * rate }
}


// Function to open a file with the user's input
fn open_file_with_user_input() {

    // Initialise the is_valid_file variable
    let mut is_valid_file = false;

    // Initialise the string to store the user's input
    let mut input = String::new();

    // Iterates while the file isn't valid
    while !is_valid_file {

        // Print the prompt
        print!("Please enter a file name:");

        // Flush the stdout
        std::io::stdout().flush().unwrap();

        // Read the user's input to the input variable
        match std::io::stdin().read_line(&mut input) {
            Ok(_number_of_bytes) => (),
            Err(error) => println!("Error: {error}")
        }

        // Set the is_valid_file variable
        is_valid_file = std::path::Path::new(&input).exists();

        // If the file is valid, open the file
        if is_valid_file {
            let my_file = std::fs::File::open(input);
        }

        // Set the input to an empty string
        input = "".to_string();
    }
}


// A function to copy text in a file
// to another file and uppercase the characters.
fn copy_text_to_another_file_and_uppercase_it(
    original_file_name: &str,
    output_file_name: &str,
) {

    // The text variable to store the string in the original file
    let text;

    // Match the value and error
    match std::fs::read_to_string(original_file_name) {
        Ok(value) => text = value,
        Err(err) => return println!("Error: {err}")
    }

    // Write to the output file
    std::fs::write(output_file_name, text.to_uppercase())
        .expect("Unable to write to file");
}


// A function to copy text in one file and prefix every line
// of the new file with a line number that starts from 1.
fn copy_text_to_another_file_and_add_line_numbers(
    original_file_name: &str,
    output_file_name: &str,
) {

    // The text variable to store the string in the original file
    let text;

    // Match the value and error
    match std::fs::read_to_string(original_file_name) {
        Ok(value) => text = value,
        Err(err) => return println!("Error: {err}")
    }

    // Write to the output file
    std::fs::write(
        output_file_name,
        text.lines().enumerate()
        .map(|(index, line)| format!("{} {line}", index + 1))
        .collect::<Vec<String>>().join("\n")
    )
    .expect("Unable to write to file");
}


// Function that print the reciprocal of integers from -10 to 10
// Print "Infinity" if the integer is 0
fn print_reciprocal_of_numbers() {

    // Iterates from -10 to 10
    for i in -10..=10 {

        // If the number is zero, print "Infinity"
        if i == 0 {
            println!("Infinity")
        }

        // Otherwise, print the reciproccal of the number
        else {
            println!("{}", 1.0 / i as f32)
        }
    }
}


// Function that prints the reciprocal of integers from -10 to 10
// Print "Infinity" if the integer is 0
// This function checks for infinity
fn print_reciprocal_of_numbers_using_check_for_inf() {

    // Iterates from -10 to 10
    for i in -10..=10 {

        // Gets the reciprocal of the number
        let reciprocal = 1.0_f32 / i as f32;

        // If the number is infinity
        if reciprocal.is_infinite() {

            // Print "Infinity"
            println!("Infinity");
        }

        // Otherwise
        else {

            // Print the reciprocal of the number
            println!("{}", reciprocal);
        }
    }
}


// Function to write the ASCII table to file
fn write_ascii_table_to_file() {

    // THe string list containing the table
    let mut ascii_table: Vec<String> = vec![];

    // The header of the table
    let header = "| No. | ASCII value | Character |".to_string();

    // Gets the length of the header
    let header_length = header.len();

    // Add the header to the list of strings
    ascii_table.push(header);

    // Add the separator to the list of strings
    ascii_table.push("-".repeat(header_length));

    // Iterates from 32 (the first printable ASCII character, " ") until 255
    for i in 32_u8..=255_u8 {

        // Gets the index of the row
        let index = i - 31;

        // Adds the required information to the table
        ascii_table.push(format!("|{index:^5}|{i:^13}|{:^11}|", i as char));
    }

    // Write the ASCII table to a file called ASCIITable.txt
    std::fs::write("ASCIITable.txt", ascii_table.join("\n"))
        .expect("Unable to write to file");
}


// Function to read a file called CarTest.txt
// and then print out the result in a nice table form.
fn pretty_print_car_test_results() {

    // The file name of the car test results
    let file_name = "CarTest.txt";

    // The string containing the text of the file
    let text;

    // The file name of the car test results
    match std::fs::read_to_string(file_name) {
        Ok(value) => text = value,
        Err(err) => return println!("Error {err}")
    }

    // The table to display the car test results
    let mut results_table: Vec<String> = vec![];

    // The list of headers for the table
    let headers = [
        "Test number",
        "Fuel consumed in litres",
        "Distance travelled in km",
        "Consumption rate in km/litres"
    ];

    // The header line
    let header_line = "| ".to_owned() + &headers.join(" | ") + " |";

    // Get the length of the header line
    let header_length = header_line.len();

    // Add the header line to the results table
    results_table.push(header_line);

    // Add the separator to the table line
    results_table.push("-".repeat(header_length));

    // Iterate over each of the lines
    for line in text.lines() {

        // Gets the splitted line
        let splitted_line: Vec<&str> = line.split(" ").collect();

        // If the length of the splitted line list is not 3,
        // continue the loop
        if splitted_line.len() != 3 {
            continue
        }

        // Gets the test results
        let test_num = splitted_line[0];
        let fuel_consumed = splitted_line[1];
        let distance_travelled = splitted_line[2];

        // Calculate the consumption rate
        let consumption_rate = distance_travelled.parse::<f32>().unwrap() /
            fuel_consumed.parse::<f32>().unwrap();

        // Add the information to the table
        results_table.push(
            format!(
                "| {:^11} | {:^23} | {:^24} | {:^29} |",
                test_num,
                fuel_consumed,
                distance_travelled,
                consumption_rate
            )
        )
    }

    // Prints the results table
    println!("{}", results_table.join("\n"));
}


// The function to convert integers to words
fn convert_integer_to_words(mut supposed_integer: String) -> Option<String> {

    // Initialise the variable to store the string "negative"
    // for negative numbers.
    // This variable will be empty if the number is positive
    let mut negative_str = "";

    // If the integer given is negative
    if supposed_integer.starts_with("-") {

        // Set the negative_str variable to "negative" with a space behind
        negative_str = "negative ";

        // Remove the dash from the start of the string
        supposed_integer = supposed_integer.replacen("-", "", 1);
    }

    // If the string given is not an integer, return None
    if !supposed_integer.chars().all(char::is_numeric) {
        return None;
    }

    // If the integer is 0, then return the word "zero"
    if supposed_integer == "0" {
        return Some("zero".to_string());
    }

    // Convert the given integer to an integer type
    let integer = supposed_integer.parse::<u64>().unwrap();

    // Create the hashmap mapping the numbers to the words
    let number_to_word_hashmap = std::collections::HashMap::from([
        (1, "one".to_string()),
        (2, "two".to_string()),
        (3, "three".to_string()),
        (4, "four".to_string()),
        (5, "five".to_string()),
        (6, "six".to_string()),
        (7, "seven".to_string()),
        (8, "eight".to_string()),
        (9, "nine".to_string()),
        (10, "ten".to_string()),
        (11, "eleven".to_string()),
        (12, "twelve".to_string()),
        (13, "thirteen".to_string()),
        (14, "fourteen".to_string()),
        (15, "fifteen".to_string()),
        (16, "sixteen".to_string()),
        (17, "seventeen".to_string()),
        (18, "eighteen".to_string()),
        (19, "nineteen".to_string()),
        (20, "twenty".to_string()),
        (30, "thirty".to_string()),
        (40, "forty".to_string()),
        (50, "fifty".to_string()),
        (60, "sixty".to_string()),
        (70, "seventy".to_string()),
        (80, "eighty".to_string()),
        (90, "ninety".to_string()),
        (100, "hundred and".to_string()),
        (10_u64.pow(3), "thousand".to_string()),
        (10_u64.pow(6), "million".to_string()),
        (10_u64.pow(9), "billion".to_string()),
        (10_u64.pow(12), "trillion".to_string()),
    ]);

    // The list of the powers of 10
    let powers_of_10 = [12, 9, 6, 3, 2, 1];

    // THe length of the power of 10 list
    let powers_of_10_len = powers_of_10.len();

    // The actual function to convert the integer to words
    fn convert_int_to_words(
        integer: u64,
        power_of_10_index: u8,
        number_to_word_hashmap: &std::collections::HashMap<u64, String>,
        powers_of_10: [u32; 6],
        powers_of_10_len: usize
    ) -> String {

        // If the integer given is inside the hashmap, return it immediately
        if let Some(value) = number_to_word_hashmap.get(&integer) {
            return if integer < 100 { value.to_string() }
                else { format!("one {}", value.to_string()) }
        }

        // If the index is greater or equal to the length of the
        // list of the powers of 10, then return an empty string
        if power_of_10_index as usize >= powers_of_10_len {
            return "".to_string();
        }

        // Get the current power of 10
        let power_of_10 = powers_of_10[power_of_10_index as usize];

        // Get the actual value of the power of 10
        let actual_value_power_of_10 = 10_u64.pow(power_of_10);

        // Get the quotient and the remainder
        let quotient = integer / actual_value_power_of_10;
        let remainder = integer % actual_value_power_of_10;

        // Initialise the quotient and remainder strings
        let mut quotient_str = String::new();
        let mut remainder_str = String::new();

        // If the quotient is greater than 0
        if quotient > 0 {

            // If the power of 10 is 1
            if power_of_10 == 1 {

                // Gets the quotient string
                quotient_str = number_to_word_hashmap.get(
                    &(quotient * actual_value_power_of_10)
                ).unwrap_or(&"".to_string()).to_string();
            }


            // Otherwise
            else {

                // Gets the quotient string and join it with the
                // string for the power of 10
                quotient_str = format!(
                    "{} {}",
                    convert_int_to_words(
                        quotient,
                        power_of_10_index + 1,
                        number_to_word_hashmap,
                        powers_of_10,
                        powers_of_10_len
                    ),
                    number_to_word_hashmap.get(
                        &(actual_value_power_of_10)
                    ).unwrap_or(&"".to_string())
                ).trim().to_string();
            }
        }

        // If the remainder is greater than 0
        if remainder > 0 {

            // Gets the remainder string
            remainder_str = convert_int_to_words(
                remainder,
                power_of_10_index + 1,
                number_to_word_hashmap,
                powers_of_10,
                powers_of_10_len
            ).trim().to_string();
        }

        // Returns the quotient string and the remainder string
        // joined with a space
        format!("{quotient_str} {remainder_str}").trim().to_string()
    }

    // Get the result of the convert_int_to_words function
    let mut result = format!(
        "{} {}",
        negative_str,
        convert_int_to_words(
            integer,
            0,
            &number_to_word_hashmap,
            powers_of_10,
            powers_of_10_len
        )
    ).trim().to_string();

    // If the result ends with "and" with a space in front, then remove it
    if result.ends_with(" and") {
        result = (&result[..result.len() - 4]).to_string();
    }

    // Return the result
    Some(result.to_string())
}


// Function to convert a file containing integers to have words instead.
// This function will make a copy of the original file.
fn convert_integer_file_to_words() {

    // The file name of the file containing integers
    let file_name = "integers.txt";

    // The string containing the text of the file
    let text;

    // The file name of the car test results
    match std::fs::read_to_string(file_name) {
        Ok(value) => text = value,
        Err(err) => return println!("Error {err}")
    }

    // The list of strings to write to the new file
    let mut str_list: Vec<String> = vec![];

    // Iterate over the lines in the file
    for mut line in text.lines() {

        // Trim the lines
        line = line.trim();

        // Convert the integer on the line to a word
        // Match statement to deal with the two cases,
        // which is when the function succeeds and when it fails
        match convert_integer_to_words(line.to_string()) {
            Some(num_in_words) => str_list.push(num_in_words),
            None => str_list.push(format!("{line} is not a valid number"))
        }
    }

    // Write the list of strings to a new file called "integers_as_word.txt"
    std::fs::write("integers_as_word.txt", str_list.join("\n"))
        .expect("Unable to write to file")
}


// The main function to run
fn main() {
    convert_integer_file_to_words()
}
