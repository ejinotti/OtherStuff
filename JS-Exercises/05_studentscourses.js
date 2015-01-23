var Student = function(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
};

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
}

Student.prototype.courses = function() {
  return this.courses;
};

Student.prototype.enroll = function(course) {

  for (var i=0; i < this.courses.length; i++) {
    if (course.conflicts_with(this.courses[i])) {
      throw "conflicting course!";
    }
  }

  course.add_student(this);
};

Student.prototype.course_load = function() {
  result = {};
  for (var i = 0; i < this.courses.length; i++) {
    var curr_course = this.courses[i];
    var curr_dept = curr_course.department;

    if (result[curr_dept]) {
      result[curr_dept] += curr_course.credits;
    } else {
      result[curr_dept] = curr_course.credits;
    }
  }

  return result;
};

var Course = function(name, department, credits, days, time_slot) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.time_slot = time_slot;
};

Course.prototype.students = function() {
  return this.students;
};

Course.prototype.add_student = function(student) {
  if (this.students.indexOf(student) != -1) {
    return;
  }
  this.students.push(student);
  student.courses.push(this);
};

Course.prototype.conflicts_with = function(other_course) {
  if (this.time_slot != other_course.time_slot) {
    return false;
  }

  for (var i=0; i < this.days.length; i++) {
    if (other_course.days.indexOf(this.days[i]) != -1) {
      return true;
    }
  }

  return false;
}
