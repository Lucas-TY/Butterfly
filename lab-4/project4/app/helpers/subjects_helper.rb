module SubjectsHelper

  # Returns the number of sections for a course given its course code
  # @param course [Course] course to count number of sections for
  # @param semester [Semester] semester to count sections from for the course
  # @return [Number] the number of sections
  def count_sections(course, semester)
    num_sections = 0
    sections = Subject.where(semester: semester, course: course)
    if sections
      num_sections = sections.length
    end
    num_sections
  end

  # Returns a string representation of the number of sections for a given course during a semester with units
  # @param course [Course] course to count number of sections for
  # @param semester [Semester] semester to count sections from for the course
  # @param singular [String] unit type to display (will add "s" when there are multiple sections/no sections)
  # @return [String] the number of sections with the appropriate units
  def disp_section_count(course, semester, singular_unit)
    units = singular_unit
    count = count_sections course, semester
    if count != 1
      units += "s"
    end
    "#{count} #{units}"
  end

  # Calculates the number of grading positions left for a section
  # @param section [Subject] section to calculate number of graders left needed for
  # @return [Number] the number of graders left needed for a section
  def count_open_grading_positions(section)
    num_positions = 0
    if section
      num_positions = section.num_graders_required - section.graders.length
    end
    num_positions
  end

  # Checks if the current user is a verified admin or instructor
  # @return [Boolean] true if the user is verified as an admin or an instructor
  def is_verified?
    (current_user.role == 'admin' || current_user.role == "instructor") && current_user.isActive
  end
end