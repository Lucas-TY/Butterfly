require "json"
class SubjectsController < ApplicationController
  def subjects
    @subjects=Subject.all
    @date_times={}
    @subjects.each do |subject|
      data= JSON.parse(subject.date_time_days)
      text=""
      data.each do |line|
        line[0].gsub("Mo","Mon ")
        line[0].gsub("Tu","Tue ")
        line[0].gsub("We","Wed ")
        line[0].gsub("Th","Thu ")
        line[0].gsub("Fr","Fri ")
        line[0].gsub("R","Sat ")
        line[0].gsub("Tu","Sun ")
        text+="#{line[0]} \t #{line[1]} \t #{line[2]}\n"
      end
      text=text.strip
      @date_times[subject.subject_id]=text
    end
    # puts @date_times
  end
end
