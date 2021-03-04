<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/alertify.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />"
	rel="stylesheet">
<title>User list</title>
</head>
<body>
	<div class="dashboard-main-wrapper">
		<%@ include file="menu.jsp"%>
		<div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">

						<div class="card ">
							<div class="card-header">
								<div class="row">
									<h2
										class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-9 topCardHeader">

										Book Lists</h2>

									<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3">
										<%if(session.getAttribute("userRole").equals("Admin")){%>
										<a href="${contextPath}/resources/view/addBook.jsp"
											class="btn btn-success topAddButton"> <i
											class="fas fa-plus"></i> &nbsp; Add Book
										</a>
										<%} %>

									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered first"
										id="bookTable">
										<thead>
											<tr>
												<th>Name</th>
												<th>Author</th>
												<th>Publisher</th>
												<th>Price</th>
												<th>Quantity</th>
												<th>Actions</th>
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

	<div class="loading" style="display: none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner">
	</div>
</body>

<script src="<c:url value="/resources/js/alertify.js" />"></script>

<script>
	var userRole = '${userRole}'
	var table;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	

	jQuery(document).ready(function(){
		
		initializeAlertifyTheme()
		
		getBooks();
		
		jQuery("#bookTable").on("click",".editBook",function(){
			editBook(jQuery(this).attr("bookId"));
		})
		
	});
	
	function editBook(bookId){
		window.location.href="${contextPath}/resources/view/addBook.jsp?id="+bookId;
	}
	
	function getBooks(){
		jQuery(".loading").show();
		
		jQuery.ajax({
			url : "${contextPath}/book",
			method : "GET",
		}).done(function(data){
			jQuery(".loading").hide();	
			if(userRole !="Admin"){
				data.map(d => {
					var action =""
					d.action = action
				})
			}else{
				data.map(d => {
					var action ="<i class='actionButton editBook fas fa-edit fa-lg' bookId='"+d.id+"' title='edit' style = 'color:#3559BA'> </i>"
					d.action = action
				})
			}
			
			loadDatatable(data)
		
		}).fail(function(){
			jQuery(".loading").hide();
			console.log("error")			
		});
	}
	
	function loadDatatable(data){
		$("#bookTable").DataTable({
			data:data,
			columns:[
				{data:'name'},
				{data:'author'},
				{data:'publisher'},
				{data:'price'},
				{data:'quantity'},
				{data:'action'}
			]
		});
	}
	
</script>
</html>