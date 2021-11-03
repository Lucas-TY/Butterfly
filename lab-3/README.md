<h1>Using the command line database</h1>

<h3>How to run</h3>
With no command line arguments : 
<pre><code>ruby ManageLocalDB.rb</code></pre>
With command line arguments : 
<pre><code>ruby ManageLocalDB.rb 'command'</code></pre>


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
<li>1222 : SP21 - Specified by default if no param given</li>

<h3>Option 2 - Using the in-program menu</h3>
<li> (Admin only) clike scrape, and then clike the the semester that you want to scrape, then clike load to load those data into database</li>


Program also supports entering commands from a built-in menu. Command list is provided upon running.
Using this option allows for running multiple commands in one run - recommended for bulk work.
