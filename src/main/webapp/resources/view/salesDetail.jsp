<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
<title>Sales Detail</title>
</head>
<body>

<div class="dashboard-main-wrapper">
		<%@ include file="/resources/view/menu.jsp" %>
		<div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<div class="col-xl-10">
						<!--====================================== --> 
						<!--  Book Form-->						
                        <!-- ===================================== -->
						 <div class="row">
						 	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
						 		<div class="card">
						 			<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Sales Detail
												</h2>
								 			</div>
											
										</div>
								 	</div>
								 	
								 	<div class="card-body">
								 	 	<div class="row">
						                	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 ">Book Name</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Quantity</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Price</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Amount</div>
						                </div>
						                
						                <div class="bookRecords">
						 						
					 					</div>
						 				<hr/>
					 					<div class="row">
					 						<div class="col-xl-7 col-lg-7 col-md-7 col-sm-7  text-right">Total Amount</div>
					                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="totalAmount">0</div>
					 					</div>
					 					<div class="row">
					 						<div class="col-xl-7 col-lg-7 col-md-7 col-sm-7  text-right">Tax</div>
					                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="tax">0</div>
					 					</div>
					 					<div class="row">
					 						<div class="col-xl-7 col-lg-7 col-md-7 col-sm-7 text-right">Vat</div>
					                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="vat">0</div>
					 					</div>
					 					<div class="row">
					 						<div class="col-xl-7 col-lg-7 col-md-7 col-sm-7  text-right">Net Total</div>
					                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="netTotal">0</div>
					 					</div>
								 	</div>
						 		</div>
						 	</div>
						 </div>
					</div>
					<!--====================================== --> 
					<!--  Book Form Ends-->						
                    <!-- ===================================== -->
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
	var id=0;
	
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery(document).ready(function() {
		initializeAlertifyTheme()
		id=getURLParameter("id")
		console.log("helloe")
		console.log(id)
		if(id != undefined){
			console.log("11")
			getSalesDetails(id)
		}
	});	
	
	function getSalesDetails(id){
		console.log("hello")
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/sales/"+id
			
		}).done(function(data){
			console.log(data)
			displaySaleDetails(data)
		});
	}
	
	function displaySaleDetails(data){
		jQuery("#totalAmount").html(data.grandTotal)
		jQuery("#tax").html(data.tax)
		jQuery("#vat").html(data.vat)
		jQuery("#netTotal").html(data.netTotal)
		var html= ""
		data.salesDetail.forEach(function(item){
			console.log(item)
			html += '<div class="row">'
			html += '<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 ">'+item.book.name+'</div>'
			html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">'+item.quantity+'</div>'
			html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">'+item.price+'</div>'
			html += '<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">'+item.total+'</div>'
			html += '</div>'
			
		})
		
		jQuery(".bookRecords").append(html)
		
	}
	function getURLParameter(param){
		
		var pageURL = window.location.search.substring(1);
		var urlVariables = pageURL.split('&')
		for(var i=0;i<urlVariables.length;i++){
			var parameterName=urlVariables[i].split('=');
			if(parameterName[0] == param){
				return decodeURIComponent(parameterName[1]);
			}
		}
	}

</script>
</html>