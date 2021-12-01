User.delete_all
Student.delete_all
GradingAssignment.delete_all
TakenCourse.delete_all
Application.delete_all


User.create(name:"admin", email:"admin@osu.edu", role:"admin", isActive:"true", password:"123456")
student_names=["jack","alice"]
student_names.each do |student_name|
  user=User.create!(
    name:"#{student_name}",
    email:"#{student_name.gsub(" ","")}@osu.edu",
    role:"student",
    isActive:"true",
    password:"123456")
  student=Student.create(
    user:user,
    availability:"true"
  )
  student.courses << Course.where(course_id:1110)[0]
  student.courses << Course.where(course_id:1111)[0]
  student.courses << Course.where(course_id:1223)[0]
  student.courses << Course.where(course_id:2221)[0]
end