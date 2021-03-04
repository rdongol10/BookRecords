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
<title>Sell Books</title></head>
<body>
	<div class="dashboard-main-wrapper">
		<%@ include file="/resources/view/menu.jsp" %>
		<div class="dashboard-wrapper">
			<div class="container-fluid dashboard-content ">
				<div class="row">
					<div class="col-xl-10">
					 <div class="row">
					 	<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
						 		<div class="card">
						 			<div class="card-header">
								 		<div class="row">
								 			<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							                    <h2 class="pageheader-title" id="pageheader-title">
							 						Sell Books
												</h2>
								 			</div>
							 			</div>
						 			</div>
						 			<div class="card-body">
						 				<div class="row">
						 					<div class="form-group col-xl-4 col-lg-4 col-md-4 col-sm-12 col4">
												<select class="form-control" id="book" name="book">
												</select>
											</div>
						                </div>
						                <hr/>
						                
						                <div class="row">
						                	<div class="col-xl-1 col-lg-1 col-md-1 col-sm-1 ">S.N.</div>
						                	<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 ">Book Name</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Quantity</div>
    							            <div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">In Stock</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Price</div>
						                	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 ">Amount</div>
						                </div>
						 				<form id="sellBookForm">
						 					<div class="bookRecords">
						 						
						 					</div>
						 					
					 					 	<hr/>
						 					<div class="row">
						 						<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10  text-right">Total Amount</div>
						                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="totalAmount">0</div>
						 					</div>
						 					<div class="row">
						 						<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10  text-right">Tax</div>
						                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="tax">0</div>
						 					</div>
						 					<div class="row">
						 						<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10  text-right">Vat</div>
						                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="vat">0</div>
						 					</div>
						 					<div class="row">
						 						<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10  text-right">Net Total</div>
						                		<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 " id="netTotal">0</div>
						 					</div>
						 					<hr/>
					 						<div class="row">
												<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-12 col2">
													<button class="btn btn-primary" id="sellBooks">
								 						Sell Books
													</button>
												</div>	
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
<script src="<c:url value="/resources/js/select2.min.js" />" ></script>
<script src="<c:url value="/resources/js/alertify.js" />" ></script>
<script type="text/javascript">
	
	var sellingBooks = []
	var errorBooks=[]
	
	function initializeAlertifyTheme(){
		
		alertify.defaults.transition = "slide";
		alertify.defaults.theme.ok = "btn btn-primary";
		alertify.defaults.theme.cancel = "btn btn-danger";
		alertify.defaults.theme.input = "form-control";
		
	}	
	
	
	function calculateTotals(){
		var total=0
		jQuery(".bookAmount").each(function(){
			if(!isNaN(jQuery(this).html())){
				total += parseInt(jQuery(this).html())
			}
		})
		
		var tax=0
		var vat=0
		var netTotal=0
		if(total>0){
			tax = total*0.13
			var afterTax= total+tax;
			vat = afterTax*0.13
			netTotal= afterTax+vat
		}
		
		jQuery("#totalAmount").html(total)
		jQuery("#tax").html(tax)
		jQuery("#vat").html(vat)
		jQuery("#netTotal").html(netTotal)
		
	}
	
	jQuery(document).ready(function(){
		initializeAlertifyTheme()
		initilizeSelect2ForBook()
		
		jQuery("#book").on('select2:select',function(e){
			getBook(e.params.data.id)
		});
		
		jQuery(".bookRecords").on("keyup",".bookQuantity",function(){
			calculateTotalForBook(this)
		})
		
		jQuery("#sellBooks").on("click",function(event){
			jQuery("#sellBooks").prop('disabled',true);
			event.preventDefault()
			sellBooks()
		})
		
	});	
	
	function sellBooks(){
		if(sellingBooks.length<=0){
			jQuery("#sellBooks").prop('disabled',false);
			console.log("mildaina save garna")
			return
		}
		
		if(errorBooks.length>0){
			jQuery("#sellBooks").prop('disabled',false);
			console.log("mildaina save garna")

			return
		}

		var salesData = getSalesData()
		jQuery(".loading").show();
		
		jQuery.ajax({
			
			method : "POST",
			url : "${contextPath}/sales",
			contentType: 'application/json; charset=UTF-8',		
			data : salesData
			
		}).done(function(data){
			console.log(data)
			jQuery(".loading").hide();
			jQuery("#addUser").prop("disabled",false);

		}).fail(function(){
			jQuery(".loading").hide();
			jQuery("#addUser").prop("disabled",false);
			alertify.alert("<div style='color:red'>An Error occured while creating the Rentee.</div>").setHeader("<b>Error</b>");
		});
		
	}
	
	function getSalesData(){
		var salesData= new Object();
		salesData.grandTotal = jQuery("#totalAmount").html()
		salesData.tax = jQuery("#tax").html()
		salesData.vat = jQuery("#vat").html()
		salesData.netTotal = jQuery("#netTotal").html()
		salesData.salesDetailDto=getSalesDetailsData()
		return JSON.stringify(salesData);
	}
	
	function getSalesDetailsData(){
		var	salesDetails = []
		jQuery(".bookRow").each(function(){
			
			var salesDetail = new Object();
			salesDetail.bookId = $(this).find(".bookId").val();
			salesDetail.price = $(this).find(".bookPrice").html();
			salesDetail.quantity = $(this).find(".bookQuantity").val();
			salesDetail.total =  $(this).find(".bookAmount").html();
			salesDetails.push(salesDetail)
		})
		
		return salesDetails
	}
	function validQuantity(quantity , instock){
		if(isNaN(quantity)){
			return "Quantity cannot be characters"
		}
		
		if(quantity>instock){
			return "Quantity cannot be more tha in stock"
		}
		
		if(quantity <=0){
			return "Quantity cannot be 0 or less"
		}
		
		return "true"
		
	}
	
	function calculateTotalForBook(element){
		var row = $(element).closest(".bookRow")
		var quantity= $(element).val()
		var amount = 0
		var validity=validQuantity(quantity,parseInt($(row).find(".bookStock").html()))
		var bookId = $(row).find(".bookId").val()
		if(validity == "true"){
			errorBooks = errorBooks.filter(item => item!==bookId)
			$(row).find(".errorFeedback").html("")
			amount = quantity * parseInt($(row).find(".bookPrice").html())
			
		}else{
			
			errorBooks.push(bookId)
			$(row).find(".errorFeedback").html(validity)
		}
		
		$(row).find(".bookAmount").html(amount)
		calculateTotals()
	}
	
	function getBook(id){
		if(sellingBooks.includes(id)){
			return
		}
		jQuery(".loading").show()
		jQuery.ajax({
			method : "GET",
			url :"${contextPath}/book/"+id
			
		}).done(function(data){
			jQuery(".loading").hide()
			jQuery(".bookRecords").append(getBookRecordHtml(data))
			sellingBooks.push(id)
			calculateTotals()
		});
	}
	
	function getBookRecordHtml(data){
		
		var html="";
		html+= '<div class="row bookRow" id="bookRow-'+booksCount+'" count="'+booksCount+'">'
		html += '<div class="form-group  col-xl-1 col-lg-1 col-md-1 col-sm-1  bookSn" id="bookSn-'+booksCount+'">'+ booksCount +'</div>'
		html += '<div class="form-group  col-xl-3 col-lg-3 col-md-3 col-sm-3  bookName" id="bookName-'+booksCount+'">'+data.name+'</div>'
		html += '<div class="form-group  col-xl-2 col-lg-2 col-md-2 col-sm-2  ">'
		html += '<input type="number" class=" form-control bookQuantity" id="bookQuantity-'+booksCount+'" value="1"  min="1" max="'+data.quantity+'" maxQuantity="'+data.quantity+'"/>'
		html += '<div class="errorFeedback" id="bookQuantity-'+booksCount+'-errorFeedback"></div>'
		html += '</div>'
		html += '<div class="form-group  col-xl-2 col-lg-2 col-md-2 col-sm-2  bookStock" id="bookStock-'+booksCount+'">'+data.quantity+'</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2  bookPrice" id="bookPrice-'+booksCount+'">'+data.price+'</div>'
		html += '<div class="form-group col-xl-2 col-lg-2 col-md-2 col-sm-2  bookAmount" id="bookAmount-'+booksCount+'">'+data.price+'</div>'
		html +='<input type="hidden" class="bookId" id="bookId-'+booksCount+'" value="'+data.id+'">'
		html += '</div>'
		booksCount++
		return html
		
	}
	
	var booksCount=1;
	
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