//** Extensions
// Getting variable from url
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
// End of Getting variable from url


//** Auto expand input text
(function($){

$.fn.autoGrowInput = function(o) {

	o = $.extend({
		maxWidth: 1000,
		minWidth: 0,
		comfortZone: 70
	}, o);

	this.filter('input:text').each(function(){

		var minWidth = o.minWidth || $(this).width(),
			val = '',
			input = $(this),
			testSubject = $('<tester/>').css({
				position: 'absolute',
				top: -9999,
				left: -9999,
				width: 'auto',
				fontSize: input.css('fontSize'),
				fontFamily: input.css('fontFamily'),
				fontWeight: input.css('fontWeight'),
				letterSpacing: input.css('letterSpacing'),
				whiteSpace: 'nowrap'
			}),
			check = function() {

				if (val === (val = input.val())) {return;}

				// Enter new content into testSubject
				var escaped = val.replace(/&/g, '&amp;').replace(/\s/g,'&nbsp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
				testSubject.html(escaped);

				// Calculate new width + whether to change
				var testerWidth = testSubject.width(),
					newWidth = (testerWidth + o.comfortZone) >= minWidth ? testerWidth + o.comfortZone : minWidth,
					currentWidth = input.width(),
					isValidWidthChange = (newWidth < currentWidth && newWidth >= minWidth)
										 || (newWidth > minWidth && newWidth < o.maxWidth);

				// Animate width
				if (isValidWidthChange) {
					input.width(newWidth);
				}

			};

		testSubject.insertAfter(input);

		$(this).bind('keyup keydown blur update', check);

	});

	return this;

};

})(jQuery);
//** End of Auto expand input text



function redirect(url){
	window.location = url;	
}

function goTo(page){
	window.history.go(page);
}

function confirmDelete(){
	if(confirm('Are you sure you want to delete this item ?')) return true;
	else return false;	
}

function trimStr(sString){
	while (sString.substring(0,1) == ' ')
	{
	sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
	sString = sString.substring(0,sString.length-1);
	}
	sString = sString.replace(/(\r\n|\n|\r)/gm,"");
	sString = sString.replace(/\s+/g,"");
	return sString;
}

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

function upperFirst(string){
	return string.charAt(0).toUpperCase() + string.slice(1);
}




























