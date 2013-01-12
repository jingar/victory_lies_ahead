# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function unhide()
{   var sport = $("#user_sport").val;
    var team = 0;
    
    if(sport != 'hurdles')
    {	team = 1;   }

    if(team==1)
    {	$('#team_name').show();  }
}
