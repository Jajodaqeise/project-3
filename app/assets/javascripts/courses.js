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
    if (searchCourse.val().length){
      courses.forEach(function(course){
        if(!enrolledCourses.includes(course.id.toString())) {
          var $results = $('.results');
          var $option = $('<div>',{
            class: 'option'
            })
            .appendTo($results)
            .click(function(){
              $('.btn').empty();
              $results.empty();
              $('#course').val(course.name);
              var studentId = $('#student_id').val();
              registerCourse(studentId, course.id);
            });

          var $name = $('<p>')
            .text(course.name)
            .appendTo($option);
          }

        })

    }



    }

  var registerCourse = function(studentId, coursesId) {
    console.log(coursesId);
    $link = $('<a>',{
      class: "register-course",
      href: '/students/'+studentId+'/courses/'+coursesId+'/register'
    })
    .text('Register')
    .appendTo($('.btn'));
  }


});
