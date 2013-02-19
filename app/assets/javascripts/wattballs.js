
var counter = 0;
var limit = 20;
var first_name = "wattball[first_name]";
var last_name = "wattball[last_name]";

var first_name_id = "wattball_first_name_";
var last_name_id = "wattball_last_name_";

function addInput(divName){
     if (counter == limit)  {
          alert("You have reached the limit of adding " + counter + " inputs");
     }
     else {
          var first_name_div = document.createElement('div');
          var last_name_div = document.createElement('div');

          first_name_div.innerHTML = "First name " + (counter + 1) + "<br><input id=" + first_name_id + counter + " type=text name="+ first_name + counter + ">";

          document.getElementById(divName).appendChild(first_name_div);

          last_name_div.innerHTML = "Last name " + (counter + 1) + "<br><input id=" + last_name_id + counter + " type=text name="+ last_name + counter + ">";

          document.getElementById(divName).appendChild(last_name_div);

          counter++;
     }
}

