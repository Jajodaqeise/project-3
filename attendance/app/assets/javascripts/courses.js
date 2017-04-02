$(()=>{

  const courseOptions = [];
  const coursesNames = [];
  const courses = [];
  const coursesId = [];
  const enrolledCourses = [];

  const searchCourse = $('#course_name');

  $('.enrolled-course').each((i, course) => {
    enrolledCourses.push($(course).attr('data-course-id'));
  });

  console.log(enrolledCourses);
  searchCourse.keyup((e) => {
      const search = searchCourse.val();
      // console.log("keyup");
      findCourse(e, search);
    })

  function findCourse(e, search){
    //empty results before doing a new course search
    $('.results').empty();
    // console.log("find", e);
    // console.log("search", search);
    const data = {
      data: search
    }
    //ajax
    $.ajax({
      method: "POST",
      data: data,
      url: "/api/find_courses",
      success: (courses)=>{
        // console.log(courses);
        dropDownOptions(courses);
      },
      error: err =>{
        console.log(err);
      }
    });
  }

  const dropDownOptions = (courses) => {
    console.log("courses", courses);

    $('.results').empty();

    for (let i = 0; i< courses.length; i++) {
      console.log(courses[i].id);
      if(!enrolledCourses.includes(courses[i].id.toString())) {
        // console.log("hey");
        courseOptions[i] = $('<div class="option">');
        // console.log("option1", courseOptions[i]);
        coursesNames[i] = courses[i].name;
        const name = $('<p>').text(coursesNames[i]);
        courseOptions[i].append(name);
        coursesId[i] = courses[i].id;
        $('.results').append(courseOptions[i]);
        courseOptions[i].click(() => {
          // console.log("click");
          const courseSelected = $('#course_name').val(coursesNames[i]);
          const studentId = $('#student_id').val();
          registerCourse(studentId, coursesId[i]);
          });
      }
    }
  }

  const registerCourse = (studentId, coursesId) => {
    $link = $('<a>',{
      href: '/students/'+studentId+'/courses/'+coursesId+'/register'
    })
    .text('register')
    .appendTo($('.btn'));
  }

});
