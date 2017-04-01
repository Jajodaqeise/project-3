$(()=>{

  const schoolLocations = [];
  const schoolNames = [];
  const schoolOptions = [];

  function getLocation() {
    navigator.geolocation.getCurrentPosition(initSearch);

    // check in button to check in at a class
    $('#checkin').click(() => {
      navigator.geolocation.getCurrentPosition(validateStudentLocation);
    });
  }

  function initSearch(location){
    console.log("init", location);
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
  getLocation();

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
        console.log("click");
        $('#course_school').val(schoolNames[i]);
        $('#course_lat').val(schoolLocations[i].lat);
        $('#course_lng').val(schoolLocations[i].lng);
      })
    }
  }

  //show course page
  const latitude = parseFloat($('#lat').val());
  const longitude = parseFloat($('#lng').val());
  const LatLng = {lat: latitude, lng: longitude};
  console.log(latitude);
  console.log(longitude);

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

  //checkin
  const checkInButton = $('#message');

  function validateStudentLocation(location) {
    // console.log("student location", location);

    const studentLat = location.coords.latitude;
      console.log("student lat", studentLat);
      console.log("course lat", latitude);
    const studentLng = location.coords.longitude;
      console.log("student lng", studentLng);
      console.log("course lng", longitude);
      // console.log("clicked");
      if( studentLat.toFixed(2) === latitude.toFixed(2) && studentLng.toFixed(2) === longitude.toFixed(2)) {
        // console.log("hello");
        checkInButton.text("You are in class");
        // ajax call

      }
      else {
        checkInButton.text("You are not in class");
      }
  }



  // $('#checkin').click(() => {
  //   const id = $('#student_id').val();
  //   $.ajax({
  //     method: "POST",
  //     data: id,
  //     url: "/attenders",
  //     success: (data)=>{
  //       console.log(data);
  //     },
  //     error: err =>{
  //       console.log(err);
  //     }
  //   })

  // })






})
