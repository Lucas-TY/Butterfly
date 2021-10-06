/**
 * A function for countup timer.
 * 
 * @author Jing Wen & Songyuan Wu
 */

function TimerCountUp() {
    var minutes = document.getElementById("minutes");
    var seconds = document.getElementById("seconds");
    var totalSeconds = 0;
    setInterval(timeSet, 1000);

    function timeSet()
    {
        // count up the time for seconds.
        totalSeconds++;
        // get the seconds and minutes respectively.
        seconds.innerHTML = pad(totalSeconds % 60);
        minutes.innerHTML = pad(parseInt(totalSeconds / 60));
    }

    function pad(value)
    {
        var strValue = value + "";
        if(strValue.length < 2)
        {
            return "0" + strValue;
        }
        else
        {
            return strValue;
        }
    }
}
