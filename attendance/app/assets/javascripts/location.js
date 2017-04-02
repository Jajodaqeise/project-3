// $(()=>{
  $(document).on('turbolinks:load', function() {

  const schoolLocations = [];
  const schoolNames = [];
  const schoolOptions = [];

  // modal
  const modal = $('#modal');
  const modalMessage = $('#modal p');

  const toggleModal = function(){
    modal.fadeToggle('fast');
  }

  function getLocation() {
    navigator.geolocation.getCurrentPosition(initSearch);
    navigator.geolocation.getCurrentPosition(
     validateStudentLocation,
     // Optional settings below
     geolocationError,
     {
         enableHighAccuracy: true,
     }
   );
  }

  function geolocationError(err){
    console.log(err);
  }

  function initSearch(location){

    // validateStudentLocation(location);

    console.log("init", location);
    // toggleModal();

    $('#course_school').keyup((e)=>{
      console.log("keyup");
      findSchool(e, location);
    })
  }

  function findSchool(e, location){
    //empty results before doing a new school search
    $('.results').empty();
    console.log("find", location);
    const data = {
      "search" : $(e.target).val(),
      "lat" : location.coords.latitude,
      "lng" : location.coords.longitude
    }
    console.log("data", data);
    //ajax
    $.ajax({
      method: "POST",
      data: data,
      url: "/api/find_schools",
      success: (schools)=>{
        console.log(schools);
        dropDownOptions(schools)
      },
      error: err =>{
        console.log(err);
      }
    })
  }
  if ($('.location-on')){
    console.log("location-on");
    getLocation();
  }


  //new and edit course pages: top 5 options of the previous search
  const dropDownOptions = (schools) => {
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
        $('.results').empty();
        console.log("click");
        $('#course_school').val(schoolNames[i]);
        $('#course_lat').val(schoolLocations[i].lat);
        $('#course_lng').val(schoolLocations[i].lng);
      })
    }
  }

  //show course page
  // toggleModal();
  const latitude = parseFloat($('#lat').val());
  const longitude = parseFloat($('#lng').val());
  const LatLng = {lat: latitude, lng: longitude};
  // console.log(latitude);
  // console.log(longitude);

  //grab this code from google maps documentation
  const mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng (latitude, longitude),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.LARGE,
      position: google.maps.ControlPosition.RIGHT_CENTER
    },
  };

  //geolocation
  map = new google.maps.Map(document.getElementById('map'), mapOptions);

  //add marker
  const marker = new google.maps.Marker({
    position: LatLng,
    map: map
  });
  // toggleModal();

  //checkin

  const studentId = parseInt($('#attender_student_id').val());
  const classId = parseInt($('#attender_class_date_id').val());
  const $checkInForm = $('.check-in-form').remove();

  function validateStudentLocation(location) {
    if ($checkInForm.length){
      console.log(location);
      // console.log("student location", location);
      const $checkClass = $('.check-class');

      const studentLat = location.coords.latitude;
      $('#student_lat').val(studentLat)
        console.log("student lat", studentLat);
        console.log("course lat", latitude);
      const studentLng = location.coords.longitude;
        $('#student_lng').val(studentLng)
        console.log("student lng", studentLng);
        console.log("course lng", longitude);
        // console.log("clicked");
        // if( studentLat.toFixed(4) === latitude.toFixed(4) && studentLng.toFixed(4) === longitude.toFixed(4)) {
        //   // console.log("hello");
        //   toggleModal();
        //   checkInButton.text("You are in class");
        //   // ajax call
        //   const student = $('#student_id').val();
        //   // console.log("student_id", student);
        //   //class date goes here to make a post ajax request
          const data = {
             student_id: studentId,
             class_id: classId,
             student_lat: studentLat,
             student_lng: studentLng
          }
          $.ajax({
            method: "POST",
            data: data,
            url: "/api/attenders/check",
            success: (data)=>{
              if (data.status){
                $('.check-in-container').append($checkInForm);
                $('#student_lat').val(studentLat);
                $('#student_lng').val(studentLng);
                $('.checked-in').remove();
                console.log("attender", data);
              } else {
                $('.check-in-icon').removeClass('fa-spinner').addClass('fa-exclamation');
                $('.checked-in>p').text('You are too far to check in');
              }
            },
            error: err =>{
              console.log(err);
            }
          })


      }

    }

      // else {
      //   checkInButton.text("You are not in class");
      //   toggleModal();
      // }


})
