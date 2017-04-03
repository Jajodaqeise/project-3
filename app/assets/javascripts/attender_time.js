$(document).on('turbolinks:load', function() {
  console.log('THIS IS A TEST');
  var $attendance = $('.attendance');
  $attendance.each(function(i, attn){
    var timeString = $(attn).attr('data-datetime');
    var timeArr = timeString.split(',');
    var time = new Date(timeArr[0], timeArr[1], timeArr[2], timeArr[3], timeArr[4], 0, 0);
    var serverTimeDif = timeArr[5].substring(1,6).split(':');
    serverTimeDif = serverTimeDif[0] + serverTimeDif[1]/60;
    console.log(serverTimeDif);
    var clientTimeDif = new Date().getTimezoneOffset() / 60;

    console.log(new Date().getTimezoneOffset());
    var totalTimeDif = clientTimeDif - serverTimeDif;
    console.log(totalTimeDif);
    // console.log(time.getUTCHours());

    var hours = time.getUTCHours();
    var formattedTime = time.toDateString() + " - ";
    formattedTime += hours % 12 == 0 ? 12 : hours % 12;
    formattedTime += ':';
    formattedTime += padNumber(time.getUTCMinutes(), 2) + ' ';
    formattedTime += hours > 11 ? "PM" : "AM";

    $(attn).children('.attendance-date').text(formattedTime);

    console.log(time);
  })

  function padNumber(number, length) {
    number = number.toString();
    while (number.length < length){
      number = "0" + number;
    }
    return number;
  }
});
