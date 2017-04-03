$(document).on('turbolinks:load', function() {
  console.log('THIS IS A TEST');
  var $attendance = $('.attendance');
  $attendance.each(function(i, attn){
    var timeString = $(attn).attr('data-datetime');
    var timeArr = timeString.split(',');
    var time = new Date(timeArr[0], parseInt(timeArr[1]) - 1, timeArr[2], timeArr[3], timeArr[4], 0, 0);
    var serverTimeDif = timeArr[5].split(':');
    serverTimeDif = serverTimeDif[1] + serverTimeDif[0] * 60;
    console.log(serverTimeDif);
    var clientTimeDif = new Date().getTimezoneOffset();

    console.log(new Date().getTimezoneOffset());
    var totalTimeDif = clientTimeDif - serverTimeDif;
    console.log(totalTimeDif);
    // console.log(time.getUTCHours());

    time.setMinutes(time.getMinutes() - totalTimeDif)
    var hours = time.getHours();
    var formattedTime = time.toDateString() + " - ";
    formattedTime += hours % 12 == 0 ? 12 : hours % 12;
    formattedTime += ':';
    formattedTime += padNumber(time.getMinutes(), 2) + ' ';
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
