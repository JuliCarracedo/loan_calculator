# LOAN CALCULATOR

Loan Calculator is a local version of the Longleaf lending Loans calculator.
Go ahead and fill the form to figure out the maximum loan and estimated profit for a real estate project.


* Ruby version
3.1.1

* System dependencies
- Docker Desktop or similar(it will handle all of the containers)
- Sqlite 3 locally for database creation

* Deployment instructions
- If you already have Docker and Sqlite3 installed, run the following commands:
  - `docker-compose build`
- Once it is done creating the images run:
  - `docker-compose up`
- Wait for it to create all 3 containers(web, redis and sidekiq)
- Go to your browser and enter `localhost:3009`

* Thought process
My first thought was (and it always is) to identify the models that would be required. In this case there was only the Loan itself.
It could probably be done without modeling at all, but Rails provides a lot of advantages if you are willing to create a model and allow ActiveRecord and the Forms helper to do the heavy lifting.
I created a first version of the form (new.html.haml) and made it submit properly to the LoansController create method, pretty standard.
The loan and profit values are calculated just before submitting the Loan so they can be stored on their own column. I beleive there is some work to be done in the calculations since the numbers look weird, but I figured it's a simplified version of the actual calculations. These calculations are in an alternative Business layer instead of the controller to keep it as small as possible.
Then I reprogrammed the form to look more like the Longleaf Lending form, which is a step-by-step process. All of the field changes and validations are made with a stimulus controller, with close to zero control in the cellphone field since it felt like missing the point of the exercise.
Once the form submitted properly and redirected to a basic 'show' page I started working on a proper dockerization that would support sidekiq and then added the letter_opener, prawn and sidekiq gems.
The LoansMailer handles the entirety of the async task by using the `deliver_later` option.
Inside the mailer, we render the PDF powered by Prawn and immediately assign it as an attachment to the email.
For some reason, letter_opener doesn't really work with async emails, but the entry is created in the /tmp/letter_opener folder, attachment and all.
