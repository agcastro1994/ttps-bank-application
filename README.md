# TPI-TPSS Arturo Castro

Bank Application

## Installation

**Cloning repository:** 
- HTTP:
  `
  git clone https://github.com/agcastro1994/ttps-bank-application.git
  `
- SSH:  `git clone git@github.com:agcastro1994/ttps-bank-application.git ` . Make sure you have configured your ssh key. 
- More info: https://docs.github.com/en/authentication/connecting-to-github-with-ssh`


**Requirement:**
- Ruby +3.0
- Rails +7.0 
 Installation tutorial (Ubuntu >= 20.04)
    : https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04 


**Dependencies installation:** 
- Run the command: `bundle install`
In case bundle fails or reported missing run: `gem install bundler` and try again

**Run the app:**
- In the application folder ( …/bank-app ) run: `bin/rails server`
Can use: `bin/dev` for a dedicated development server 


## Documentation

**Design Notes**

The build of the CRUD for the entities was straight forward, following the rails principles to build routes and MVC. The heavy duty was to implement a consistent and scalable appointments functionality. The design was divided in two: Shifts and the appointments. 

1. Shifts are the time period assigned to an appointment. We establish some ground rules:
-   Shift duration:  30 minutes. 
        `Example: Monday schedule 10:00-16:00 has 12 shifts -> 10:00-10:30, 10:30-11:00, etc.`

The appointment shift selection, will be implemented as a form select, and the list to populate it will be build following this logic: 
`
List.size == shifts_amount  -> [ start , start + 30 min, …., end - 30 min]`


- The amount of shift’s spaces will be equal to the office's assigned operators. With previous example: 3 operators -> 12 shifts x 3 op = 36 possible appointments for that monday (3 per shift).Taking all shift’s spaces, removes the shift for future selections. 

    `Shifts amount calculation = (difference in minutes between start and end ) / 1.minutes / 30 without rest. `

For simplicity the schedule time picker are locked to select times based on 15 min spaces. `Example: 10:00 - 10:15 - 10:30 - 10:45.` In the worst scenario the division will throw 15 minutes as rest, those minutes will not be taken into consideration.

2. For the appointments, the idea was to make it clear and simple for the user. I try to avoid making the user select any day and any hour without knowing if that selection has open shifts. In that scenario if the office does not have availability for one month the user will be selecting too many combinations of day/hours without reason and without success. 


- Problem: Implement a system that filters open shifts when the user starts filling the appointment information.

- Solution: I build a 3 steps form. In the first step the user type the reason of the appointment (possibly a fixed list of options in a future iteration) and select the office. This information is stored in the session and is used to build the next step. In second step the idea was to show a datepicker with the days that has open shifts in the next month (today + 30 days). 

Because of the time limitation, for the moment only a datepicker with past days and days beyond the 30 days scope blocked was implemented in this step. If the user selects a day without shifts the system will notify it. Selecting a day successfully will lead the user to the final step, with a list of the shifts that are still open. On Submit, all the info collected in the session will be merged with the shift selection and the appointment will be created. 

Appointment flow: `Appointment flow -> from appointments view / navbar -> new appointment-> multi-step form.`

Multi-step-form: `View for office and reason selection -> Load days between the next 30 days. ->  View for day selection -> Load open shifts for the selected day -> View for shift selection -> creation`


3. One last minute decision was to add a regular expression to filter phone numbers. I choose for a simple one that allows numbers such: 

- Buenos Aires format: `1112345678 / 11-1234-5678 (spaces, ‘.’ or ‘-’ are optionals)` 
- La plata format: `2211234567/ 221-123-4567 (spaces, ‘.’ or ‘-’ are optionals) `
- Numbers with country extension: ` +54 221-123-4567 (space between extension is not optional) `   

**Regex:** ` ^(\+\d{1,2}\s)?\(?\d{2,3}\)?[\s.-]?\d{3,4}[\s.-]?\d{4}$`

## Authors

- [@agcastro1994](https://www.github.com/agcastro1994)

