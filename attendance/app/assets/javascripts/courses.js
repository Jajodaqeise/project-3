$(()=>{

  const searchCourse = $('#course_name');


  searchCourse.keyup((e) => {
      const search = searchCourse.val();
      console.log("keyup");
      findCourse(e, search);
    })

  function findCourse(e, search){
    //empty results before doing a new course search
    // $('.results').empty();
    console.log("find", e);
    console.log("search", search);
    const data = {
      data: search
    }
    //ajax
    $.ajax({
      method: "POST",
      data: data,
      url: "/api/find_courses",
      success: (courses)=>{
        console.log(courses);
        dropDownOptions(courses);
      },
      error: err =>{
        console.log(err);
      }
    });
  }

  const dropDownOptions = (courses) => {
  console.log("schools", schools);

  $('.results').empty();

  for (let i = 0; i< 5; i++) {
    schoolOptions[i] = $('<div class="option">');
    schoolNames[i] = schools[i].name;
    const name = $('<p>').text(schoolNames[i]);
    schoolOptions[i].append(name);
    schoolLocations[i] = schools[i].geometry.location;
    $('.results').append(schoolOptions[i]);
    schoolOptions[i].click(() => {
      console.log("click");
      $('#course_school').val(schoolNames[i]);
      $('#course_lat').val(schoolLocations[i].lat);
      $('#course_lng').val(schoolLocations[i].lng);
    })
    }
  }

});
