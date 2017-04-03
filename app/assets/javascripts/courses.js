$(document).on('turbolinks:load', function() {

  var courseOptions = [];
  var coursesNames = [];
  var courses = [];
  var coursesId = [];
  var enrolledCourses = [];

  var searchCourse = $('#course');

  searchCourse.keyup(function(e) {
      var search = searchCourse.val();
      // console.log("keyup");
      findCourse(e, search);
    })

  function findCourse(e, search){
    //empty results before doing a new course search
    $('.results').empty();
    // console.log("find", e);
    // console.log("search", search);
    var data = {
      data: search
    }
    //ajax
    $.ajax({
      method: "POST",
      data: data,
      url: "/api/find_courses",
      success: function(courses){
        // console.log(courses);
        dropDownOptions(courses);
      },
      error: function(err){
        console.log(err);
      }
    });
  }

  $('.enrolled-course').each(function(i, course) {
    enrolledCourses.push($(course).attr('data-course-id'));
  });

  console.log(enrolledCourses);

  var dropDownOptions = function(courses) {
    console.log("courses", courses);

    $('.results').empty();

    for (var i = 0; i< courses.length; i++) {
      console.log(courses[i].id);
      if(!enrolledCourses.includes(courses[i].id.toString())) {
        // console.log("hey");
        courseOptions[i] = $('<div class="option">');
        // console.log("option1", courseOptions[i]);
        coursesNames[i] = courses[i].name;
        var name = $('<a>').text(coursesNames[i]);
        courseOptions[i].append(name);
        coursesId[i] = courses[i].id;
        $('.results').append(courseOptions[i]);
        courseOptions[i].click(function() {
          $('.btn').empty();
          console.log("click");
          $('.results').empty();
          var courseSelected = $('#course').val(coursesNames[i]);
          console.log("course selected", courseSelected);
          var studentId = $('#student_id').val();
          registerCourse(studentId, coursesId[i]);
        });
      }
    }
  }

  var registerCourse = function(studentId, coursesId) {
    $link = $('<div class="register-course" ><a>',{
      href: '/students/'+studentId+'/courses/'+coursesId+'/register'
    })
    .text('Register in this course')
    .appendTo($('.btn'));
  }


});
