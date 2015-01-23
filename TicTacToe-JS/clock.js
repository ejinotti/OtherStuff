function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {

  var time = '';
  time += (this.hours < 10) ? '0' + this.hours : this.hours;
  time += ':';
  time += (this.minutes < 10) ? '0' + this.minutes : this.minutes;
  time += ':';
  time += (this.seconds < 10) ? '0' + this.seconds  : this.seconds;

  console.log(time);

  return;
};

Clock.prototype.run = function () {
  this.startTime = new Date;

  this.hours = this.startTime.getHours();
  this.minutes = this.startTime.getMinutes();
  this.seconds = this.startTime.getSeconds();

  this.printTime();

  setInterval(this._tick.bind(this), Clock.TICK);

  return;

  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {

  if (this.seconds + 5 >= 60) {
    this.seconds = (this.seconds + 5) % 60;
    this.minutes++;
  } else {
    this.seconds += 5;
  }

  if ( this.minutes >= 60) {
    this.minutes = 0;
    this.hours++;
  }

  this.hours = this.hours % 24;

  this.printTime();

  return;

  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
