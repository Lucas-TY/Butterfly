# rail database setup

I create a sample database by rail use command:

```bash
rails generate model subject course_id:string subject_id:string autoenrolls:string  date_time_days:string elw:string teacher:string

rake db:migrate

```

And then I create a migrate file to convert json into database.

The code is in Addjsons.rb, because I am working on a independent part,so i just give the method to import data to rail database. The construct of rail application rely on my coworkers.

# If you want to change the model

If you want to change the model fields, you can modify the **20211020153140_addjsons.rb** in db/migrate dir and then:

```
rake db:rollback
rake db:migrate
```

These lines will drop the old database and create a new one according to your change.

I also create a simple view and controller to show the data I defined, see subject.

**Hint:**

The SQLite3 file here is just a sample (it is copied from my simple app).

