<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
</head>
<body>
	<div class="dashboard-main-wrapper">

	<%@ include file="/resources/view/menu.jsp" %>  
	
	    <div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<%if(session.getAttribute("userRole").equals("Admin")){%>
						<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="userContainer">
							<div class="card homeIconContainer" >
								<div class="card-body ">
									<div class="homeIcon bg-primary-light">
										<i class="fas fa-user fa-2x text-primary homeIconImage"></i>
									</div>
									<div class="homeIconText">
										Users
									</div> 
								</div>
							</div>
						</div>
					<%} %>
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="BookContainers">
						<div class="card homeIconContainer" >
							<div class="card-body ">
								<div class="homeIcon bg-warning-light">
									<i class="fas fa-book fa-2x text-warning homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Books
								</div> 
							</div>
						</div>
					</div>
					
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="sellBookContainer">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-success-light">
									<i class="fas fa-file-invoice-dollar fa-2x text-success homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Sell Books
								</div> 
							</div>
						</div>
					</div>
					
					<div class="col-xl-3 col-lg-3 col-md-6 col-sm-12 col-12 col3" id="salesReportContainer">
						<div class="card homeIconContainer">
							<div class="card-body ">
								<div class="homeIcon bg-violet-light">
									<i class="fas fa-file-alt fa-2x text-violet homeIconImage"></i>
								</div>
								<div class="homeIconText">
									Sales Report
								</div> 
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>	
	</div>
</body>

<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery("#userContainer").on("click",function(){
			window.open("${contextPath}/resources/view/listUsers.jsp","_blank");
		})	
		
		jQuery("#BookContainers").on("click",function(){
			window.open("${contextPath}/resources/view/listBooks.jsp","_blank");
		})	
		
		jQuery("#sellBookContainer").on("click",function(){
			window.open("${contextPath}/resources/view/sellBooks.jsp","_blank");
		})	
		
		jQuery("#salesReportContainer").on("click",function(){
			window.open("${contextPath}/resources/view/salesReport.jsp","_blank");
		})	
	})
</script>
</html>