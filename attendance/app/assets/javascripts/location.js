$(()=>{

  schoolLocations = [];
  schoolNames = [];

  function getLocation() {
    navigator.geolocation.getCurrentPosition(initSearch);
  }

  function initSearch(location){
    console.log(location);
    $('#course_school').keyup((e)=>{
      findSchool(e, location);
    })
  }

  function findSchool(e, location){
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

  //new and edit course pages: top 5 options
  const dropDownOptions = (schools) => {
    console.log("schools", schools);

    $('.results').empty();

    for (let i = 0; i< 5; i++) {
      const option = $('<div class="option">');
      schoolNames[i] = schools[i].name;
      const name = $('<p>').text(schoolNames[i]);
      option.append(name);
      schoolLocations[i] = schools[i].geometry.location;
      $('.results').append(option).click(() => {
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
  var marker = new google.maps.Marker({
    position: LatLng,
    map: map
  });




















})
