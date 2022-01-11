# OSU CSE Grading Assignment Web Application

Deployed on a sever: https://butterfly.lucas-ty.space/
<br>
Admin login: 
  + email: admin@admin.admin
  + password: 123456

# Initial Setup

## Step 1: Accessing the web view
+ While in the project4 folder, first run the command <code>bundle install --without production</code> to install all of the necessary gems
+ Next, you might need to run <code>rails db:migrate</code> before your first time running the server
+ Finally, run the command <code>rails s</code> to start the web server.
  + To access the website, now go to <link>http://localhost:3000/</link> in a browser of your choice (recommended: chrome)
  + If you run into an issue when running the server for the first time where the application.js file is not found, you need to run: <code>rails webpacker:install.</code>

---

## Step 2: Jquery Setup
To create the time selector we use jquery, to add jquery to rails, run <code>yarn add  jquery </code> in  project4 root dir. Settings have been changed in application.js and environment.js.

<em>Only follow the next two steps if you had to run webpacker:install</em>

+ In project4/app/javascript/packs/application.js, replace the file's contents with:
  ```
  import Rails from "@rails/ujs"
  import Turbolinks from "turbolinks"
  import * as ActiveStorage from "@rails/activestorage"
  import "channels"
  require("jquery")
  Rails.start()
  Turbolinks.start()
  ActiveStorage.start()

  window.jQuery = $;
  window.$ = $;
  ```
+ In project4/config/webpack/environment.js, replace the file's contents with:
  ```
  const { environment } = require('@rails/webpacker')

  const webpack = require('webpack')
  environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
      $: 'jquery/src/jquery',
      jQuery: 'jquery/src/jquery'
    })
  )

  module.exports = environment

  ```

## Step 3: Add a default admin account

To create a default admin account (the initial administrator to the database), you must add them through the command line
  + Open the rails console: <code>rails console</code>
  + Enter the following command (replace [ ] with user chosen values): 
    ```
    User.create(name:[name], email:[email], role:"admin", isActive:"true", password:[password])
    ```
  + example: 
    ```
    User.create(name:"admin", email:"admin@admin.admin", role:"admin", isActive:"true", password:"123456")
    ```
  + Exit the console using the command: <code>quit</code>

---

# Website Functionality and Assumptions

## admins
+ Functions:
  + Manage Users
    + admins can verify any unverified admin and instructor accounts
    + admins can delete users
  + Manage Application
    + Select a semester to display applications to sections for that semester
    + Either assign a grading position to one section for an application or reject the application
  + Manage Recommendation
    + Select a semester to display recommendations to sections for that semester
    + Either assign a grading position to one section for a recommendation or reject the recommendation
  + View Evaluations
    + Select a grader to view all of their evaluations
    + Only shows graders that are assigned to a currently available semester
  + Manage Semester
    + Add a semester with the following information
      + code - The code used for scraping data for that specific semester (currently increments by 4 every semester)
        + see examples of semester codes in the Web Scraper details below 
      + description - a brief title/description for the semester
    + At least one semester must be added to the database before scraping any course data.
    + When deleting a semester, all corresponding sections that were linked the semester are also deleted.
  + Scraper
    1. Select a semester to frist scrape course/section data. This data will be stored in an intermediate folder.
    2. Load the data into the corresponding semester. This will remove all sections stored in the database for that semester before loading in the newly scraped section data.
      + This will load whatever data was last scraped into the selected semester.
      + It is possible to load the scraped data into a different semester. This is intentially designed in case an admin needs to archive a semester's data without changing the semester code. Be careful when loading data that the correct semester is being loaded. 
  + Sections
    + In the "change positions" column, an admin can change the amount of graders needed for a section. By default, each section requires 1 grader.

## Instructors
+ Functions:
  + Add/Manage Courses
    + Add sections that the instructor account teaches/manages
    + Add a recommendation for a student to grade for the given section.
    + Add an evaluation for a student that graded for the section
+ Assumptions:
  + Only one instructor can be assigned to a section at a time

## Students
+ Functions:
  + Add Courses
    + Adds sections to the student's history of taken courses.
    + A student must have a course listed as being taken before they are able to apply for that course. Otherwise, an instructor must recommend them for a specific section.
+ Assumptions:
  + An application is only intended to apply for one position (must apply multiple times to get multiple positions)
  + A student can only apply to courses that they have taken
---

## Developers: How to use the database

+ *see documentation on the database's relationships and schema design*
+ When saving an object to the database, make sure that all of the required foreign keys are added to the object
  + <code>has_many</code>: use the <code> << </code> operator to add an object to the list of foreign keys of another.
    + example: 
    ```
      @user = User.create email: "email@email.com", name: "Test Student", password: "password"
      @student = Student.create user: @user
      @application = Application.create

      @student.applications << @application
    ```
  + <code>has_one</code>: use the <code> = </code> operator to link a single object to the foreign keys of another.
    + example:
    ```
      @user = User.create! email: "user1@email.com", password: "123456", name: "user"
      @instructor = Instructor.create
      @user.instructor = @instructor
    ```
  + ignore the grading_assignments and taken_courses members (they are used to link models that have many-to-many relationships. Instead, use the member with the :through option to add these relationships)
    + example: 
    ```
      @user = User.create email: "email3@email.com", name: "Test Student", password: "password"
      @course = Course.create
      @student = Student.create user: @user
      @section = Subject.create course: @course

      @student.sections << @section
    ```
  + *see tests for examples on how to link objects to foreign keys*

---

# OSU CSE Course Web Scraper (Copied from Project 3)
<em> All commands shown are demonstrating how to run the command line arguments while inside the project4 directory </em>

## Handling Users
+ Users can be created through the web view by clicking the "Sign Up" link in the navigation bar.
+ While creating an account, you must choose your role (student, instructor, or administrator)
  + Instructors and administrators must be verified by a current admin before they have access to role specific features
  + The default view of both roles will be the student view until verified.
+ To create a default admin account (the initial administrator to the database), you must add them through the command line
  + Open the rails console: <code>rails console</code>
  + Enter the following command (replace [ ] with user chosen values): 
  <br>
        <code>User.create(name:[name], email:[email], role:"admin", isActive:"true", password:[password])</code>
+ Admin controls
  + While logged into a verified admin account, you can access the "Manage Users" navigation link
  + This page allows you to verifty instructors and admins, as well as delete any user.


---
## Scraping Data from the web
+ Only verified admins have the ability to scrape new course information into the database
+ When loged in as an admin, you can access the navigation link "Scraper"
+ To first scrape new information, select the "scrape" button (this process should only take a few seconds)
+ After data has been scraped, select the "load" button to load the scrapped data into the database (this can take up to 30 seconds)

---

<h1>Using the command line database</h1>

<h3>How to run</h3>

With no command line arguments : 
<pre><code>ruby scrapeAndStore/ManageLocalDB.rb</code></pre>
With command line arguments : 
<pre><code>ruby scrapeAndStore/ManageLocalDB.rb 'command'</code></pre>


<h3>Option 1 - Using command line arguments</h3>

Program supports 1 argument on each run. If multiple commands must be used, recommended to use option 2.
<h4>Command list + functionality:</h4>
<ol>
<li>"list" : Lists information for each class that has been scraped from the course search website</li>
<li>"list xxxx" : Replace 'xxxx' with a class number to list information for that specific course number</li>
<li>"update xxxx" : Scrapes the course search website to update local information using specified term code</li>
</ol>

<h4>Term codes for Update</h4>
<ul>
<li>1214 : SU21</li>
<li>1218 : AU21</li>
<li>1222 : SP22 - Specified by default if no param given</li>
</ul>
<h3>Option 2 - Using the in-program menu</h3>
  <h4>Scrape data</h4>
<ul>
<li> (Admin only) click scrape, and then click the the semester that you want to scrape, then click load to load those data into database</li>
</ul>

---

Reference
  - [html Canvas-nest](https://github.com/hustcc/canvas-nest.js)
