$(document).ready(function(){
	$(".dataForm").validate({
		rules: {
			/*username: {
				minlength: 6,
				maxlength: 20
			},
			'data[currPassword]':{
				minlength: 3,
				maxlength: 20
			},*/
			'data[reNewPassword]':{
				equalTo: '#newPassword'	
			}
		}/*,
		messages: {
			username: {
				required: 'Please enter username',
				minlength: 'Username too short',
				maxlength: 'Username too long'
			},
			rePassword: {
				required: 'Re-enter the password',
				equalTo: 'Please enter the same password again'	
			},
			email: {
				required: 'Enter email address',
				email: 'Invalid email address'
			}
    	}*/
		/*,
		errorPlacement: function(error,element) {
			//return true;// use this if don't want to display error
        	//error.insertAfter(element);
       	}*/
	});
	
	
	
	
});