const config = {
  startOnMonday: true
}
const calFactory = ()=>{
  const monthDays = [31,28,31,30,31,30,31,31,30,31,30,31];
  const cal = {
    init: function(){
      this.dateArr = [];
      this.today = new Date();
      this.createMonth(this.today.getMonth(), this.today.getFullYear());

      return this;
    },
    createMonth: function(month, year){
      const firstDay = new Date(year, month, 1, 0, 0, 0, 0);
      console.log(firstDay);
      let startDayOfWeek = firstDay.getDay();
      if (config.startOnMonday){
        startDayOfWeek = startDayOfWeek === 0 ? 7 : startDayOfWeek - 1;
      }
      for(let i = 0; i < startDayOfWeek ; i++){
        this.dateArr.push("");
      }
      for (let i=1; i<=monthDays[firstDay.getMonth()]; i++){
        this.dateArr.push(i);
      }
      this.dateArr = _.chunk(this.dateArr, 7);
      while (this.dateArr[this.dateArr.length -1].length < 7){
        this.dateArr[this.dateArr.length-1].push("");
      }

      return this;
    },
    renderCal: function($parent){
      var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      if (config.startOnMonday){
        daysOfWeek.push(daysOfWeek.shift());
      }
      const $table = $('<table>',{
          class: "cal"
        })
        .appendTo($parent);
      const $caption = $('<caption>',{
          class: "cal-month"
        })
        .appendTo($table)
        .text(monthNames[this.today.getMonth()]);
      const $tablehead = $('<tr>',{
          class: "cal-day-of-week-row cal-row"
        })
        .appendTo($table);
      daysOfWeek.forEach(day=>{
        const $th = $('<th>',{
          class: "cal-day-of-week cal-cell"
        })
        .appendTo($tablehead)
        .text(day);
      });
      this.dateArr.forEach(week=>{
        const $tr = $('<tr>', {
          class: "cal-row cal-week-row"
        })
        .appendTo($table);
        week.forEach(day=>{
          const $td = $('<td>',{
            class: "call-cell cal-day"
          })
          .appendTo($tr)
          .text(day);
        })
      })

      return this;
    }
  }
  return cal;
}

$(()=>{
  //const cal = calFactory().init().renderCal($('body'));
})
