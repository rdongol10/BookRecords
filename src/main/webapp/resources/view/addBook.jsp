<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/alertify.css" />" rel="stylesheet"> 
<link href="<c:url value="/resources/css/alertify-bootstrap.css" />" rel="stylesheet">
<title>Add Book</title>
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
							 						Add Book
												</h2>
												<p class="pageheader-text">Please fill all the required fields(<span class="requiredField">*</span>) to add the user</p>
								 			</div>
											
										</div>
								 	</div>
								 	
								 	<div class="card-body">
									 	<form id="bookForm">
									 		<div class="row">
												<input id="id" name="id" type="hidden">
									 			<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="bookName" class="col-form-label">Book Name<span class="requiredField">*</span></label>
	                                                <input id="bookName" name="bookName" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="bookName-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="publisher" class="col-form-label">Publisher<span class="requiredField">*</span></label>
	                                                <input id="publisher" name="publisher" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="publisher-errorFeedback"></div>
	                                            </div>
	                                            <div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="author" class="col-form-label">Author<span class="requiredField">*</span></label>
	                                                <input id="author" name="author" type="text" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="author-errorFeedback"></div>
	                                            </div>
									 		</div>
									 		
									 		<div class="row">
									 			<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
	                                                <label for="price" class="col-form-label">Price<span class="requiredField">*</span></label>
	                                                <input id="price" name="price" type="number" class="form-control requiredInputs" value=''>
													<div class="errorFeedback" id="price-errorFeedback"></div>
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
													<button class="btn btn-primary" id="addBook">
								 						Add Book
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

<script src="<c:url value="/resources/js/alertify.js" />" ></script>
<script src="<c:url value="/resources/js/jquery.inputmask.bundle.js" />" ></script>
<script src="<c:url value="/resources/js/inputmask.js" />" ></script>

<script>

	var errorFields = []
	var mode ="save";
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
		
		if(id != undefined){
			mode = "edit"
			jQuery("#bookName").attr("disabled","disabled");
			jQuery("#quantity").attr("disabled","disabled");
			jQuery("#addBook").html("Edit Book")
			jQuery("#pageheader-title").html("Edit Book")
			getBook(id)
		}else{
			mode ="save";
			jQuery("#addBook").html("Add Book")
			jQuery("#pageheader-title").html("Add Book")
		}
		
		
		jQuery("#addBook").on("click", function(event) {
			jQuery("#addBook").prop('disabled',true);
			event.preventDefault()
			removeErrorHighlights()
			if (validateInputs()) {
				if(mode =="save"){
					saveBook()
				}else if(mode=="edit"){
					updateBook(id)
				}
			} else {
				highlightErrorFields()
				jQuery("#addBook").prop('disabled',false);
			}

		});
		
	})
	
	function getBook(id){
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/book/"+id
			
		}).done(function(data){
			loadBookData(data)
		});
	}
	
	function loadBookData(data){
		jQuery("#id").val(data.id);
		jQuery("#bookName").val(data.name);
		jQuery("#publisher").val(data.publisher);
		jQuery("#author").val(data.author);
		jQuery("#price").val(data.price);
		jQuery("#quantity").val(data.quantity);
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
	
	function saveBook(){
		
		jQuery(".loading").show();
		var book=getBookData();
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/book",
			contentType: 'application/json; charset=UTF-8',	
			data:book
		}).done(function(data){
		
			window.location.href="${contextPath}/resources/view/listBooks.jsp";
		
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addBook").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while creating the Book.</div>").setHeader("<b>Error</b>");
		
		});
	}
	
	function updateBook(id){
		jQuery(".loading").show();
		var book=getBookData();
		jQuery.ajax({
			method : "PUT",
			url : "${contextPath}/book/"+id,
			contentType: 'application/json; charset=UTF-8',	
			data:book
		}).done(function(data){
		
			window.location.href="${contextPath}/resources/view/listBooks.jsp";
		
		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addBook").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while creating the user.</div>").setHeader("<b>Error</b>");
		
		});
	}
	
	function getBookData(mode){
		var bookData = new Object();
		if(mode=="edit"){
			bookData.id=jQuery("#id").val();
		}
		
		bookData.name = jQuery("#bookName").val() 
		bookData.publisher = jQuery("#publisher").val()
		bookData.author = jQuery("#author").val()
		bookData.price = jQuery("#price").val()
		bookData.quantity = jQuery("#quantity").val()
		return JSON.stringify(bookData)
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
		validatePrice()
		if(mode == "save"){
			doesBookNameExists()
		}
		return !errorFields.length > 0;
	}

	function doesBookNameExists(){
		var bookName=jQuery("#bookName").val()
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/book/bookexists/"+bookName,
			async: false,
			success:function(data){
				console.log(data)
				if(data){
					var errorField = {};
					errorField.id = "bookName"
					errorField.message = "Book Name already exists";
					errorFields.push(errorField)
				}
			}
		});
	}
	function validatePrice(){
		var price= jQuery("#price").val();
		if(price<0){
			var errorField = {};
			errorField.id = "price"
			errorField.message = "Price cannot be less than zero";
			errorFields.push(errorField)
		}
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