$(()=>{

  const schoolLocations = [];
  const schoolNames = [];
  const schoolOptions = [];

  function getLocation() {
    navigator.geolocation.getCurrentPosition(initSearch);
  }

  function initSearch(location){
    console.log("init", location);
    $('#course_school').keyup((e)=>{
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

  function getLocation() {
    console.log("geolocation works");
      if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(validatePosition);
      } else {
          checkInButton.innerHTML = "Geolocation is not supported by this browser.";
      }
  }

  function validatePosition(position) {
    console.log("hey");
    console.log("position", position);

    const studentLat = position.coords.latitude;
      console.log("student lat", studentLat);
    const studentLng = position.coords.longitude;
      console.log("student lng", studentLng);
    $('#checkin').click(() => {
      console.log("clicked");
      if( studentLat === latitude && studentLng === longitude) {
        console.log("hello");
        checkInButton.text("You are in class");
        // ajax call
      }
      else {
        checkInButton.text("You are not in class");
      }

    });
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
