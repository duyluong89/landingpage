// JavaScript Document

// Extension for getting variable from url
$.extend({
  getUrlVars: function(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    return vars;
  },
  getUrlVar: function(name){
    return $.getUrlVars()[name];
  }
});
// End of extension


$(document).ready(function(){
	
	// Set current class to menu (code:01)
	var current_menu = $.getUrlVar('c');
	if(!current_menu)	current_menu='home';
	$('#menu ul li a').each(function(){
		if($(this).attr('rel')==current_menu)
			$(this).addClass('selected');
		else{
			$(this).removeClass('selected');	
		}
	});
	
	// Check all,check one
	$(".checkall").click(function()				
	{
		var checked_status = this.checked;
		$("input.check").each(function()
		{
			this.checked = checked_status;
		});
	});	
	
	$('input.check').click(function(){
		var flag=1;
		$('input.check').each(function(){
			if(this.checked==false)
				flag=0;
			else flag=flag*1;
		});
		if(flag==0)
			$('.checkall').removeAttr('checked');
		else $('.checkall').attr('checked','checked');
		
	});
	
	// confirm delete
	$('.delete').click(function(){
		if(checkConfirm()){
			$('.adminForm').submit();
		}
		else return false;
	});
	
	function checkConfirm(){
		var flag = 1;
		$('.check').each(function(){
			if($(this).is(':checked')){
				flag = flag * 0;	
			}
			else{
				flag = flag * 1;	
			}
		});
		if(flag == 0){
			if(confirm('Are you sure you want to delete this item ?')) return true;
			else return false;
		}
		else{
			return false;	
		}	
	}
	
});