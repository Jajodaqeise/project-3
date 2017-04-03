
  $(document).on('turbolinks:load', function() {

    $logout = $('#log_them_out');
    console.log("Log them out");
    if($logout && $logout.length){
      $logout.click();
    }

  var schoolLocations = [];
  var schoolNames = [];
  var schoolOptions = [];

  // modal
  var modal = $('#modal');
  var modalMessage = $('#modal p');

  var toggleModal = function(){
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

    $('#course_school').keyup(function(e){
      console.log("keyup");
      findSchool(e, location);

    })
  }

  function findSchool(e, location){
    //empty result-school before doing a new school search
    $('.result-school').empty();

    console.log("find", location);
    var data = {
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
      success: function(schools){
        console.log(schools);
        dropDownOptions(schools)
      },
      error: function(err){
        console.log(err);
      }
    })
  }

  if ($('.location-on')){
    console.log("location-on");
    getLocation();
  }


  //new and edit course pages: top 5 options of the previous search
  var dropDownOptions = function(schools) {
    $('.results-school').empty();
    if ($('#course_school').val().length){
      if (schools.length > 5){
        schools = schools.slice(0,5);
      }
      console.log("====================",schools);

      var $results = $('.results-school').empty();

      schools.forEach(function(school){
        console.log("SCHOOL", school)
        console.log('results', $results)
        var $option = $('<div>',{
          class: 'option'
        })
        .appendTo($results)
        .click(function(e){
          $results.empty();
          $('#course_school').val(school.name);
          $('#course_lat').val(school.geometry.location.lat);
          $('#course_lng').val(school.geometry.location.lng);
        });
        var $name = $('<p>')
          .text(school.name)
          .appendTo($option);
      })

    }

  }

  //show course page
  // toggleModal();
  var latitude = parseFloat($('#lat').val());
  var longitude = parseFloat($('#lng').val());
  var LatLng = {lat: latitude, lng: longitude};
  // console.log(latitude);
  // console.log(longitude);

  //grab this code from google maps documentation
  var mapOptions = {
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
  var marker = new google.maps.Marker({
    position: LatLng,
    map: map
  });
  // toggleModal();

  //checkin

  var studentId = parseInt($('#student_id').val());
  var classId = parseInt($('#class_date_id').val());
  var $checkInForm = $('.check-in-form').remove();

  function validateStudentLocation(location) {
    if ($checkInForm && $checkInForm.length){
      console.log(location);
      // console.log("student location", location);
      var $checkClass = $('.check-class');

      var studentLat = location.coords.latitude;
      $('#student_lat').val(studentLat)
        console.log("student lat", studentLat);
        console.log("course lat", latitude);
      var studentLng = location.coords.longitude;
        $('#student_lng').val(studentLng)
        console.log("student lng", studentLng);
        console.log("course lng", longitude);
        // console.log("clicked");
        // if( studentLat.toFixed(4) === latitude.toFixed(4) && studentLng.toFixed(4) === longitude.toFixed(4)) {
        //   // console.log("hello");
        //   toggleModal();
        //   checkInButton.text("You are in class");
        //   // ajax call
        //   var student = $('#student_id').val();
        //   // console.log("student_id", student);
        //   //class date goes here to make a post ajax request
          var data = {
             student_id: studentId,
             class_id: classId,
             student_lat: studentLat,
             student_lng: studentLng
          }
          $.ajax({
            method: "POST",
            data: data,
            url: "/api/attenders/check",
            success: function(data){
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
            error: function(err){
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
