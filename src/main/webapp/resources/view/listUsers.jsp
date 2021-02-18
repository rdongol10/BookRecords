<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
	<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
	<title>User list</title>
</head>
<body>
<div class="dashboard-main-wrapper">
		<%@ include file="menu.jsp" %>  
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
						 
						<div class="card ">
							<div class="card-header">
						 		<div class="row">
				                    <h2 class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9 topCardHeader">
					 				
						 				User Lists 
						 					
									</h2>
									
				                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										
								        <a href="${contextPath}/resources/view/addUser.jsp" class="btn btn-success topAddButton" >
									    	<i class="fas fa-plus"></i>  &nbsp; Add User
										</a>
										
									</div>
								</div>
						 	</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered first" id="userTable">
										<thead>
											<tr>
											    <th>User Name</th>
											    <th>First Name</th>
											    <th>Middle Name</th>
											    <th>Last Name</th>
											    <th>Sex</th>
											    <th>Phone Number</th>
		 									    <th>Email Address</th>
											    <th>Type of User</th>
											    <th>Actions </th>
											</tr>
										</thead>
									</table>	
								</div>
							</div>	
						</div>
					</div>
				</div>
			</div>	
		</div>	
	</div>

	<div class="loading" style="display:none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner" >
	</div>
</body>

<script src="<c:url value="/resources/js/alertify.js" />" ></script>

<script>
	var table;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	jQuery(document).ready(function(){

		initializeAlertifyTheme()
		
		getUsers()
		
		jQuery("#userTable").on("click",".editUser",function(){
			editUser(jQuery(this).attr("userId"));
		})
		
		jQuery("#userTable").on("click",".deleteUser",function(){
			jQuery(".actionButton").prop('disabled', true);
			var userId=jQuery(this).attr("userId")
			alertify.confirm(
				"Confirm",
				"Are you sure you want to delete the User",
				function(){deleteUser(userId)},
				function(){jQuery(".actionButton").prop('disabled', false);}
			)
		})
	})
	
	function editUser(userId){
		window.location.href="${contextPath}/resources/view/addUser.jsp?id="+userId;
	}
	
	function deleteUser(userId){
		jQuery(".loading").show();
		jQuery.ajax({
			method : "DELETE",
			url : "${contextPath}/user/"+userId,
		}).done(function(data){
			jQuery(".loading").hide();
			jQuery(".actionButton").prop('disabled', false);
			location.reload();
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery(".actionButton").prop('disabled', false);
			alertify.alert("<div style='color:red'>An Error occured while trying to delete the user.</div>").setHeader("<b>Error</b>");

		});
	}
	
	function getUsers(){
		jQuery(".loading").show();
		
		jQuery.ajax({
			url : "${contextPath}/user",
			method : "GET",
		}).done(function(data){
			jQuery(".loading").hide();		
			data.map(d => {
				var action ="<i class='actionButton editUser fas fa-edit fa-lg' userId='"+d.id+"' title='edit' style = 'color:#3559BA'> </i>"
				action += "<i class='actionButton deleteUser fas fa-trash-alt fa-lg' userId='"+d.id+"' title='disable' style = 'color:#FF686B'></i>"
				d.action = action
			})
			loadDatatable(data)
		
		}).fail(function(){
			jQuery(".loading").hide();
			console.log("error")			
		});
	}
	
	function loadDatatable(data){
		$("#userTable").DataTable({
			data:data,
			columns:[
				{data:'userName'},
				{data:'firstName'},
				{data:'middleName'},
				{data:'lastName'},
				{data:'sex'},
				{data:'phoneNumber'},
				{data:'email'},
				{data:'typeOfUser'},
				{data:'action'}
			]
		});
	}
</script>

</html>