<<<<<<< HEAD
<!-- BEGIN: main -->
<div id="menu">
	{html}
</div>  
<div style="height:48px">
	
</div>   

<script>
	
	$('.ul_cap1 .li_cap1').click(function(){
		var id_dm = $(this).attr('id_dm');
		
		$.ajax({               
				type: "POST",
				url: nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=categories',
				data: {id_dm : id_dm},
				success: function(json) {
				console.log(json);
					
				},                 
				error: function(xhr, ajaxOptions, thrownError) {
					console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}                  
			});
		
		//console.log(id_dm);
	});

</script>
=======
<!-- BEGIN: main -->
<div id="menu">
	{html}
</div>  
<div style="height:48px">
	
</div>   

<script>
	
	$('.ul_cap1 .li_cap1').click(function(){
		var id_dm = $(this).attr('id_dm');
		
		$.ajax({               
				type: "POST",
				url: nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=categories',
				data: {id_dm : id_dm},
				success: function(json) {
				console.log(json);
					
				},                 
				error: function(xhr, ajaxOptions, thrownError) {
					console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}                  
			});
		
		//console.log(id_dm);
	});

</script>
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
<!-- END: main -->