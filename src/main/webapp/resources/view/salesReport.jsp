<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
<title>Sales Report</title>
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
							 						Sales Report
												</h2>
								 			</div>
											
										</div>
								 	</div>
								 	
								 	<div class="card-body">
								 		<form id="bookForm">
									 		<div class="row">
									 			<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="fromDate" class="col-form-label">From Date<span class="requiredField">*</span></label>
	                                                <input id="fromDate" name="fromDate" type="text" class="form-control requiredInputs datepicker" value='' readonly>
													<div class="errorFeedback" id="fromDate-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="toDate" class="col-form-label">To Date<span class="requiredField">*</span></label>
	                                                <input id="toDate" name="toDate" type="text" class="form-control requiredInputs datepicker" value='' readonly>
													<div class="errorFeedback" id="toDate-errorFeedback"></div>
	                                            </div>
	                                            
									 		</div>
									 		
									 		<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-12 col2">
													<button class="btn btn-primary" id="search">
								 						Search
													</button>
												</div>	
											</div>
											
											<hr/>
									 		<div class="table-responsive">
												<table class="table table-striped table-bordered first"
													id="filterTable">
													<thead>
														<tr>
															<th>Invoice no.</th>
															<th>Sold By</th>
															<th>Sold Date</th>
															<th>Grand total</th>
															<th>Tax</th>
															<th>Vat</th>
															<th>Net Total</th>
															<th>Action</th>
														</tr>
													</thead>
												</table>
											</div>
									 	</form>		
								 	</div>
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
	var errorFields = []
	function initializeAlertifyTheme(){
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
	}	
	
	jQuery(document).ready(function() {
		initializeAlertifyTheme()
		jQuery("#filterTable").DataTable()
		jQuery(".datepicker").datepicker({ 
			dateFormat: 'yy-mm-dd' 
		})
		
		jQuery("#search").on("click",function(){
			jQuery("#search").prop('disabled',true);
			event.preventDefault()
			searchRecords()
		})
		
	});
	
	function searchRecords(){
		
		jQuery(".loading").show();
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/sales/getSalesRecords",
			contentType: 'application/json; charset=UTF-8',	
			data:getfilterData()
		}).done(function(data){
		
			console.log(data)
			jQuery("#search").prop('disabled',false);
			loadDataTable(data)
			jQuery(".loading").hide();

		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#search").prop('disabled',false);
			alertify.alert("<div style='color:red'>An Error occured .</div>").setHeader("<b>Error</b>");
		
		});
	}
	
	function loadDataTable(data){
		
		data.map(d => {
			var action ="<i class='actionButton details fas fa-eye fa-lg' bookId='"+d.id+"' title='details' style = 'color:#3559BA'> </i>"
			d.action = action
		})
		
		jQuery("#filterTable").DataTable().destroy()
		jQuery("#filterTable").DataTable({
			data:data,
			columns:[
				{data:'id'},
				{data:'user'},
				{data:'soldDate'},
				{data:'grandTotal'},
				{data:'tax'},
				{data:'vat'},
				{data:'netTotal'},
				{data:'action'}
			]
		})
	}
	
	function getfilterData(){
		var filterData = new Object();
		
		filterData.startDate = jQuery("#fromDate").val() 
		filterData.endDate = jQuery("#toDate").val()
		return JSON.stringify(filterData)
	}
</script>

</html>