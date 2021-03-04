<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/select2.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/select2-bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
<title>Add Quantity</title>
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
							 						Add Stock
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the user</p>
								 			</div>
											
										</div>
								 	</div>
								 	
								 	<div class="card-body">
									 	<form id="bookQuantityForm">
									 		<div class="row">
									 			<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
													<label for="book" class="col-form-label">Book<span class="requiredField">*</span></label>
													<select class="form-control requiredInputs" id="book" name="book">
													</select>
													<div class="errorFeedback" id="book-errorFeedback">
														
													</div>
								                </div>
								                
								                <div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="quantity" class="col-form-label">Quantity<span class="requiredField">*</span></label>
	                                                <input id="quantity" name="quantity" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="quantity-errorFeedback"></div>
	                                            </div>
									 		</div>
									 		
									 		<br>
											<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-12 col2">
													<button class="btn btn-primary" id="addQuantity">
								 						Add
													</button>
												</div>	
											</div>
									 	</form>
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
<script src="<c:url value="/resources/js/select2.min.js" />" ></script>
<script src="<c:url value="/resources/js/alertify.js" />" ></script>

<script type="text/javascript">

	var errorFields = []
	
	function initializeAlertifyTheme(){
		
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
		
	}	
	
	
	jQuery(document).ready(function(){
		initilizeSelect2ForBook()
		initializeAlertifyTheme()
		
		jQuery("#addQuantity").on("click",function(event){
			jQuery("#addQuantity").prop('disabled',true);
			event.preventDefault()
			removeErrorHighlights()
			
			if (validateInputs()) {
				
					saveBookStock()
					
			} else {
				highlightErrorFields()
				jQuery("#addQuantity").prop('disabled',false);
			}
		});
		
	});	
	
	
	function saveBookStock(){
		jQuery(".loading").show();
		
		var bookStockData = new Object();
		bookStockData.bookId= jQuery("#book").val();
		bookStockData.quantity=jQuery("#quantity").val();
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/bookInventory/addStock",
			contentType: 'application/json; charset=UTF-8',	
			data:JSON.stringify(bookStockData)
		}).done(function(data){
		
			window.location.href="${contextPath}/resources/view/listBooks.jsp";
		
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addQuantity").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while adding St.</div>").setHeader("<b>Error</b>");
		
		});
		
	}
	
	function removeErrorHighlights(){
		jQuery(".errorFeedback").html("");
		jQuery(".form-control").css("border-color","");

	}
	
	function highlightErrorFields() {
		if (errorFields.length < 1) {
			return;
		}

		errorFields.forEach(function(value, index) {
			var id = value.id;
			var message = value.message
			jQuery("#" + id).css("border-color", "red");
			jQuery("#" + id + "-errorFeedback").html(message)
		})
	}
	
	function validateInputs() {

		if(!validateRequiredFields()){
			return false;
		}
		
		if(!validateOtherFields()){
			return false;
		}
		
		return true;
	}
	
	function validateRequiredFields() {
		errorFields = []
		jQuery(".requiredInputs:visible").each(function() {
			var errorField = {};

			if (this.value.trim() == "") {
				errorField.id = jQuery(this).attr("id");
				errorField.message = "Required field connot be empty";
				errorFields.push(errorField)
			}

		})

		return !errorFields.length > 0

	}
	
	function validateOtherFields(){
		errorFields = []
		validateQuantity()
		return !errorFields.length > 0;
	}

	
	function validateQuantity(){
		var quantity= jQuery("#quantity").val();
		if(quantity<0){
			var errorField = {};
			errorField.id = "quantity"
			errorField.message = "Quantity cannot be less than zero";
			errorFields.push(errorField)
		}
	}
	
	function initilizeSelect2ForBook(){
		jQuery("#book").select2({
			theme: "bootstrap",
			ajax:{
				method : "POST",
				url :"${contextPath}/book/getBooksForSelect2",
				dataType: 'json',
				data:function(param){
					var term =param.term!=undefined ? param.term : ""
					var value ={search :term}
					return value;
				}, 
				processResults: function (data) {
					return {
						results: data
					};
				}
			}
		});
	}
	
</script>
</html>