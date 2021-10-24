# web scraping and store the data of course info into json files.

require 'mechanize'
require 'json'
$id=""
$state_num=0
$course_id=ARGV[0]
# $course_id=1110
puts "scraping CSE #{$course_id}"


def generate_data(action)
    subData={
      "ICAJAX" =>  1,
      "ICNAVTYPEDROPDOWN" =>  0,
      "ICType" =>  "Panel",
      "ICElementNum" =>  0,
      "ICStateNum" =>  $state_num,
      "ICAction" =>  action,
      "ICModelCancel" =>  0,
      "ICXPos" =>  0,
      "ICYPos" =>  0,
      "ResponsetoDiffFrame" =>  -1,
      "TargetFrameName" =>  "None",
      "FacetPath" =>  "None",
      "ICFocus" =>  "",
      "ICSaveWarningFilter" =>  0,
      "ICChanged" =>  -1,
      "ICSkipPending" =>  0,
      "ICAutoSave" =>  0,
      "ICResubmit" =>  0,
      "ICSID"=>$id,
      "ICBcDomData" =>  "UnknownValue",
      "ICPanelName" =>  "",
      "ICFind" =>  "",
      "ICAddCount" =>  '',
      "ICAppClsData" =>  '',
    }
    $state_num+=1
    return subData
end
class_dict={
  "CLASS_SRCH_WRK2_INSTITUTION$46$"=>1,
  "CLASS_SRCH_WRK2_INSTITUTION$31$"=>"OSUSI",
  'CLASS_SRCH_WRK2_STRM$35$' =>  1222,
  'SSR_CLSRCH_WRK_CAMPUS$0' =>  "COL",
  'SSR_CLSRCH_WRK_SUBJECT_SRCH$1' =>  "CSE",
  'SSR_CLSRCH_WRK_CATALOG_NBR$2' =>  $course_id,
  'SSR_CLSRCH_WRK_SSR_OPEN_ONLY$chk$4' =>  "N",
  'SSR_CLSRCH_WRK_ACAD_CAREER$3' =>  "",
}

$agent = Mechanize.new
page=$agent.get("https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL")
$id=page.at("#ICSID").values[3]

data=generate_data("CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH")
data.update(class_dict)
page=$agent.post('https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL',data)
c=page.at("#win0divPAGECONTAINER").children.text
doc=Nokogiri::HTML(c)
table=doc.search("//tr[starts-with(@id, 'trSSR_CLSRCH_MTG1$')]")
contents=[]
i=0
puts "start subject scraping"
table.each do |row|
    subject_data={}
    subject_data["course_id"]=$course_id
    outer_array=[]
    outer_array.append row.search(".//span[starts-with(@id,'MTG_CLASS_NBR')]").text.strip
    outer_array.append row.search(".//span[starts-with(@id,'MTG_CLASSNAME')]").text.strip
    outer_array.append row.search(".//span[starts-with(@id,'MTG_DAYTIME')]").text.strip
    outer_array.append row.search(".//span[starts-with(@id,'MTG_ROOM')]").text.strip
    outer_array.append row.search(".//span[starts-with(@id,'MTG_INSTR')]").text.strip
    outer_array.append row.search(".//span[starts-with(@id,'MTG_TOPIC')]").text.strip
    subject_data["outer_info"]=outer_array

    data=generate_data("MTG_CLASSNAME$#{i}")
    res=$agent.post('https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL',data)


    detail_doc= Nokogiri::HTML(res.at("#win0divPAGECONTAINER").children.text)

    subject_data["open_status"]=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_SSR_DESCRSHORT']").text
    subject_data["subject_number"]=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_CLASS_NBR']").text
    subject_data["session"]=detail_doc.search("//span[@id='PSXLATITEM_XLATLONGNAME$31$']").text
    subject_data["units_range"]=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_UNITS_RANGE']").text
    subject_data["instruct_mode"]=detail_doc.search("//span[@id='INSTRUCT_MODE_DESCR']").text
    subject_data["components"]=detail_doc.search("//div[@id='win0divSSR_CLS_DTL_WRK_SSR_COMPONENT_LONG']").text.strip
    subject_data["career"]=detail_doc.search("//div[@id='win0divSSR_CLS_DTL_WRK_ACAD_CAREERlbl']").text.strip
    subject_data["dates"]=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_SSR_DATE_LONG']").text.strip
    subject_data["grading"]=detail_doc.search("//span[@id='GRADE_BASIS_TBL_DESCRFORMAL']").text.strip
    subject_data["location"]=detail_doc.search("//span[@id='CAMPUS_LOC_VW_DESCR']").text.strip
    subject_data["campus"]=detail_doc.search("//span[@id='CAMPUS_TBL_DESCR']").text.strip


    subject_data["date_times"]=[]
    meetings=detail_doc.search("//tr[starts-with(@id,'trSSR_CLSRCH_MTG')]")
    meetings.each do |meeting|
        array=[]
        array.append meeting.search(".//span[starts-with(@id,'MTG_SCHED')]").text.strip
        array.append meeting.search(".//span[starts-with(@id,'MTG_LOC')]").text.strip
        array.append meeting.search(".//span[starts-with(@id,'MTG_INSTR')]").text.strip
        array.append meeting.search(".//span[starts-with(@id,'MTG_DATE')]").text.strip
        subject_data["date_times"].append(array)
    end


    subject_data['enroll']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_SSR_CRSE_ATTR_LONG']").text.strip


    subject_data['class_cap']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_ENRL_CAP']").text.strip
    subject_data['enroll_total']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_ENRL_TOT']").text.strip
    subject_data['available_seats']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_AVAILABLE_SEATS']").text.strip
    subject_data['wait_list_cap']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_WAIT_CAP']").text.strip
    subject_data['wait_list_total']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_WAIT_TOT']").text.strip

    subject_data['description']=detail_doc.search("//span[@id='DERIVED_CLSRCH_DESCRLONG']").text.strip

    subject_data['textbook']=detail_doc.search("//span[@id='SSR_CLS_DTL_WRK_SSR_CLS_TXB_MSG']").text.strip


    data=generate_data("CLASS_SRCH_WRK2_SSR_PB_BACK")
    res=$agent.post('https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL',data)

    i+=1
    contents.append(subject_data)
    # puts JSON.generate(subject_data)
    # puts subject_data
    puts "scrape #{i}th subject"
end

text=JSON.generate(contents)
f=File.new("result/#{$course_id}.json","w")
f.syswrite(text)
f.close