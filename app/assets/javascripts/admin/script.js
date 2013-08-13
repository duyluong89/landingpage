// JavaScript Document
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
	
	
	
	// Selection language - Block content
	$('#block_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var id = $('#block_form input[name="id"]').val();
		var pageId = $('#block_form input[name="pageId"]').val();
		var url = 'index.php?c=blocks&task=edit&pageId='+pageId+'&id='+id+'&languageCode='+languageCode+'#languageSelect';
		redirect(url);
	});
	
	// Selection language - Page text
	$('#page_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var id = $('#page_form input[name="id"]').val();
		var pageId = $('#page_form input[name="pageId"]').val();
		var url = 'index.php?c=page&task=edit&id='+id+'&languageCode='+languageCode+'#languageSelect';
		redirect(url);
	});
	
	// Selection language - App form
	$('#app_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var id = $('#app_form input[name="id"]').val();
		var pageId = $('#page_form input[name="pageId"]').val();
		var url = 'index.php?c=app&task=edit&id='+id+'&languageCode='+languageCode+'#languageSelect';
		redirect(url);
	});
	
	// Selection language - popup_form
	$('#popup_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var pageId = $('#pageSelect').val();
		var url = 'index.php?c=popup&task=edit&pageId=' + pageId + '&languageCode='+languageCode;
		redirect(url);
	});
	
	$('#popup_form .pageSelect').change(function(){
		var pageId = $(this).val();
		var url = 'index.php?c=popup&task=edit&pageId=' + pageId;
		redirect(url);
	});
	
	// Selection language - splash_form
	$('#splash_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var pageId = $('.pageSelect').val();
		var url = 'index.php?c=splash&task=edit&pageId='+pageId+'&languageCode='+languageCode/*+'#languageSelect'*/;
		redirect(url);
	});
	
	// Selection language - Link text
	$('#social_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var url = 'index.php?c=other&task=edit&languageCode='+languageCode+'#languageSelect';
		redirect(url);
	});
	
	// Selection language - Ads form
	$('#ads_form .languageSelect').change(function(){
		var languageCode = $(this).val();
		var id = $('#ads_form input[name="id"]').val();
		var url = 'index.php?c=ads&task=edit&id='+id+'&languageCode='+languageCode+'#languageSelect';
		redirect(url);
	});
	
	// Selection landing page - Ads form
	 $('#ads_form .pageSelect').change(function(){
		var pageId = $(this).val();
		//var id = $('#ads_form input[name="id"]').val();
		var url = 'index.php?c=ads&task=viewList&pageId='+pageId+'#pageSelect';
		redirect(url);
	 });
	
	// Select user level - User form
	$('#user_form .levelSelect').change(function(){
		var level = $(this).val();
		if (level == 100){
			$('#user_form .leader').attr('style', 'display: blocks;');
		}
		else{
			$('#user_form .leader').attr('style', 'display: none');
		}
		//var url = 'index.php?c=ads&task=edit&id='+id+'&languageCode='+languageCode+'#languageSelect';
		//redirect(url);
	});
	
	// Check exits username before submit - User form
	$('#user_form .dataForm').submit(checkExitsUsername);
	$('#user_form #txtUsername').keyup(checkExitsUsername);
	
	function checkExitsUsername() {
		var username = $('#txtUsername').val();
		var listUsername = $('#txtListUsername').val();
		var arr = listUsername.split(";");
		if(username.length != 0)
		for(i = 0; i < arr.length; i++){
			if(username == arr[i]) {
				$('#lblMsg').html("Username is exits.");
				$('#txtUsername').focus();
				return false;
			}
		}
		$('#lblMsg').html("");
		return true;
	}
	
	// Selection page - splash_form
	$('#splash_form .pageSelect').change(function(){
		var pageId = $(this).val();
		var url = 'index.php?c=splash&task=edit&pageId='+pageId/*+'#pageSelect'*/;
		redirect(url);
	});
	
	$('.confirmDelete').click(function(){
		if(confirmDelete()){
			url = $(this).attr('rel');
			redirect(url);
		}
	});
	
	$('.popup_tab span').click(function(){
		$('.popup_tab span.active').removeClass('active');
		$(this).addClass('active');
		var rel = $(this).attr('rel');
		$('.form > div').hide();
		$('#'+rel).show();
		$('#tab').attr('value',rel);
	});
	
	tab = $('#tab').attr('value');
	if(tab == '')
		tab = 'as';
	$('.popup_tab span').each(function(){
		rel = $(this).attr('rel');
		if(rel == tab){
			$(this).addClass('active');
			$('#'+rel).show();
		}
	});
	
	$('.open_gallery').click(function(){
		parentId = $(this).parent().attr('id');
		var width = 900;
		var height = 520;
		var top = 100;
		var left = (window.innerWidth - width)/2;
		settings = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable="no",toolbar="no",scrollbars="no",status="no",location="no"';
		//myWindow = window.open('../lib/thirdParty/elfinder/elfinder.php?id='+parentId,'',settings);
       myWindow = window.open('elfinder','',settings);
		myWindow.focus();
		
	});
	
	$('.open_gallery2').click(function(){
		parentId = $(this).parent().parent().parent().attr('id');
		var width = 900;
		var height = 520;
		var top = 100;
		var left = (window.innerWidth - width)/2;
		settings = 'width='+width+',height='+height+',top='+top+',left='+left+',resizable="no",toolbar="no",scrollbars="no",status="no",location="no"';
		myWindow = window.open('../library/thirdParty/elfinder/elfinder.php?id='+parentId+'&pageId=language_list','',settings);
		myWindow.focus();
		
	});
	
	$('input[type="file"]').change(function(){
		//id = $(this).parent().parent().attr('id');
		//$('#'+id+' .thumb_image div img').attr('src','');
		//$('#'+id+' input[type="hidden"]').val('');
		var file = $(this).get(0).files[0];
		if (file.size > 102400)	{
			alert('The file size you are about to upload is more than 100Kb.\n It is recommeded to use the smaller files for faster page loading.');
		}
	});
	
	$('#language_list .update').click(function(){
		var action = $(this).attr('rel');
		$('#language_list form').attr('action',action);
		$('#language_list form').submit();
	});
	
	$('#language_list .add').click(function(){
		$('#language_list form').submit();
	});
	
	//** Color picker
	$('.color_picker').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});
	
	$('#remove_img').click(function(){
		$('#img_logo').attr('visibility','hidden');
		alert('d');
	});
	
	//** Preview
	/*$('.preview').click(function(){
		var rel = $(this).attr('rel');
		$('#preview').load(rel);
		$('#preview').fadeIn();
		$('#close_preview').show();
	});
	$('#close_preview').click(function(){
		$('#preview').fadeOut();
		$(this).hide();
		location.reload();
	});*/
	
	//** Expand input text
	$('.expandable').autoGrowInput({
		comfortZone: 10,
		minWidth: 240,
		maxWidth: 500
	});
	// Customize expand
	/*$('.expandable').each(function(){ //$('<p>Test</p>').insertAfter('.inner');
		$('<u class="cal_width"></u>').insertAfter($(this));
		var cal_width = $(this).parent().find('.cal_width');
		cal_width.html($(this).val());
		var new_width = cal_width.width();
		new_width = new_width > 240?new_width:240;
		new_width = new_width < 500?new_width:500;
		$(this).width(new_width);
	});*/
	
	
	// ** Check max length 
	$('#block_form .section1').click(function(){
		if($('#block_form .checkbox').attr('checked') == 'checked'){
			$(this).attr('maxlength','40');
		}
		else{
			$(this).attr('maxlength','70');
		}
	});
	
	$('#block_form .section2').click(function(){
		if($('#block_form .checkbox').attr('checked') == 'checked'){
			$(this).attr('maxlength','65');
		}
		else{
			$(this).attr('maxlength','60');
		}
	});
	
	/*$('.limited_length').keypress(function(){
		var len = $(this).val().length;
		var maxlen = $(this).attr('data-maxlen');
		maxlen = maxlen - 1;
		var content = $(this).val();
		content = content.substring(0,maxlen);
		if(len > maxlen){
			$(this).val(content);
		}
	});*/
	
	//** Remove picture
	$('.thumb_image > div').each(function(){
		var content = $(this).html();
		if(trimStr(content) != ''){
			$(this).parent().find('.remove_img > span').show();	
		}
		else{
			$(this).parent().find('.remove_img > span').hide();		
		}
	});
	
	$('.remove_img > span').click(function(){
		$(this).parent().parent().find('div').html('');
		$(this).hide();
		var parId = $(this).parent().parent().parent().attr('id');
		$('input[name="g'+upperFirst(parId)+'"]').val('');
		$('input[name="old'+upperFirst(parId)+'"]').val('');
	});

	//** Date time picker
	$('.datetime').datepicker();
	
	//** Processing checkbox in the form
	$('form input[type="checkbox"]').click(function(){
		var parent = $(this).parent();
		if(this.checked == true){
			var hidden = parent.find('input[type="hidden"]');
			if($(this).attr('name') == ''){
				var name = hidden.attr('name');
				$(this).attr('name',name);
			}
			hidden.attr('name','');
		}
		else{
			var name = $(this).attr('name');
			parent.find('input[type="hidden"]').attr('name',name);
			$(this).attr('name','');
		}
	});
	$('form').ready(function(){
		$('input[type="checkbox"]').each(function(){
			if($(this).attr('checked') == 'checked'){
				$(this).parent().find('input[type="hidden"]').attr('name','');
			}
		});
	});
	
	//** Hide report message of the form after 5 seconds
	/*$('form').ready(function(){
		var msg = $('.msg');
		if(trimStr(msg.text()) != ''){
			//** Waiting 5 seconds before disappearing
			setTimeout(function() {
				msg.text('');
			}, 5000);	
		}
	});*/
	
	//** Hide report message of the form after 5 seconds
	$('.notification').ready(function(){
		//** Waiting 5 seconds before disappearing
		setTimeout(function() {
			$('.notification').fadeOut();
		}, 5000);
	});
	
	
	
});