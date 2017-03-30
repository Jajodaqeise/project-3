$(()=>{
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
    console.log("find", location);
    const data = {
      search: $(e.target).val(),
      lat: location.coords.latitude,
      lng: location.coords.longitude
    }
    //ajax
    $.ajax({
      method: "GET",
      data: data,
      processData: false,
      contentType: false,
      url: "/api/find_schools",
      success: (data)=>{
        console.log(data);
      },
      error: err =>{
        console.log(err);

      }
    })
  }
  getLocation();
})

