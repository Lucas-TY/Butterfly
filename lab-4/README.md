# OSU CSE Grading Assignment Web Application

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
  <br>
        <code>User.create(name:[name], email:[email], role:"admin", isActive:"true", password:[password])</code>
  + example: <code>User.create(name:"admin", email:"admin@admin.admin", role:"admin", isActive:"true", password:"123456")</code>
  + Exit the console using the command: <code>quit</code>

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
<em> All commands shown are demonstrating how to run the command line arguments while inside the project3 directory </em>

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

<h3>Option 2 - Using the in-program menu</h3>
  <h4>Scrape data</h4>
<li> (Admin only) click scrape, and then click the the semester that you want to scrape, then click load to load those data into database</li>

---

  <h4>add/delete course(project 4 part)</h4>
  <li> click planner, then input the course that you are looking for. You can click on add or drop to change your courses</li>


Program also supports entering commands from a built-in menu. Command list is provided upon running.
Using this option allows for running multiple commands in one run - recommended for bulk work.

---

## Update

### Add a addTestData script to add two student with some taken_courses.

Run it with rails runner: `rails runner addTestData/add_test_student.rb`

student 1:  
email: jack@osu.edu   |   password: 123456

student 2:  
email: jack@osu.edu   |   password: 123456

Admin:  
email: admin@osu.edu   |   password: 123456