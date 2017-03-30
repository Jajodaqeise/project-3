$(()=>{

  schoolLocations = [];
  schoolNames = [];


  function getLocation() {
    navigator.geolocation.getCurrentPosition(initSearch);
  }

  function initSearch(location){
    $('#course_school').keyup((e)=>{
      findSchool(e,location);
    })
  }

  // const search = (location) => {
  //   $('#course_school').keyup((e)=>{
  //     findSchool(e, location);
  //   })
  // }

  function findSchool(e, location){
    console.log("find", location);
    const data = {
      "search" : $(e.target).val(),
      "lat" : location.coords.latitude,
      "lng" : location.coords.longitude
    }
    console.log(data);
    //ajax
    $.ajax({
      method: "POST",
      data: data,
      url: "/api/find_schools",
      success: (schools)=>{
        console.log(schools);
        // dropDownOptions(schools)
      },
      error: err =>{
        console.log(err);

      }
    })
  }
  getLocation();

  // const dropDownOptions = (schools) => {
  //   console.log("schools", schools);

  //   $('.results').empty();

  //   for (let i = 0; i< 5; i++) {
  //     const option = $('<div class="option">');
  //     schoolNames[i] = schools[i].name;
  //     const name = $('<p>').text(schoolNames[i]);
  //     option.append(name);
  //     schoolLocations[i] = schools[i].geometry.location;
  //     $('.results').append(option).click(() => {
  //       $('#course_school').val(schoolNames[i]);
  //       $('#course_lat').val(schoolLocations[i].lat);
  //       $('#course_lng').val(schoolLocations[i].lng);
  //     })
  //   }
  // }

})

