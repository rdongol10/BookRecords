<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/datatables.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/fonts/fontawesome/css/fontawesome-all.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

	<title>Menu</title>
</head>
<body>
	 <!-- ============================================================== -->
        <!-- navbar -->
        <!-- ============================================================== -->
        <div class="dashboard-header">
        	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
			
            <nav class="navbar navbar-expand-lg bg-white fixed-top">
                <a class="navbar-brand" href="${contextPath}/">Home</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto navbar-right-top">
                        <li class="nav-item dropdown nav-user">
                            <a class="nav-link nav-user-img" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-users"></i></a>
                            <div class="dropdown-menu dropdown-menu-right nav-user-dropdown" aria-labelledby="navbarDropdownMenuLink2">
                                <div class="nav-user-info">
                                    <h5 class="mb-0 text-white nav-user-name"><%= session.getAttribute("userName") %></h5>
                                    <span class="status"></span><span class="ml-2"><%= session.getAttribute("userId") %></span>
                                </div>
                                <a class="dropdown-item" href="${contextPath}/resources/view/changePassword.jsp"><i class="fas fa-cog mr-2"></i>Change Password</a>
                                <a class="dropdown-item" href="${contextPath}/logout"><i class="fas fa-power-off mr-2"></i>Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
		<!-- ============================================================== -->
        <!-- end navbar -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- left sidebar -->
        <!-- ============================================================== -->
        <div class="nav-left-sidebar sidebar-dark">
            <div class="menu-list">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <a class="d-xl-none d-lg-none" href="#">Dashboard</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav flex-column">
		                      
                            <li class="nav-divider">
                                Menu
                            </li>
                            <%if(session.getAttribute("userRole").equals("Admin")){%>
                            
	                            <li class="nav-item ">
	                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#userMenu" aria-controls="userMenu">Users </a>
	                                <div id="userMenu" class="collapse submenu" style="">
	                                    <ul class="nav flex-column">
	                                        <li class="nav-item">
	                                            <a class="nav-link" href="${contextPath}/resources/view/listUsers.jsp">List Users</a>
	                                        </li>
	                                        <li class="nav-item">
	                                            <a class="nav-link" href="${contextPath}/resources/view/addUser.jsp">Add Users</a>
	                                        </li>
	                                    </ul>
	                                </div>
	                            </li>
                            
                            <%} %>
                            
                            <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#booksMenu" aria-controls="booksMenu">Books </a>
                                <div id="booksMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/listBooks.jsp">List Books</a>
                                        </li>
                                        <%if(session.getAttribute("userRole").equals("Admin")){%>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addBook.jsp">Add Book</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/addBookQuantity.jsp">Add Book Stock</a>
                                        </li>
                                        <%} %>
                                    </ul>
                                </div>
                            </li>
                            
                             <li class="nav-item ">
                                <a class="nav-link active" href="#" data-toggle="collapse" aria-expanded="false" data-target="#salesMenu" aria-controls="salesMenu">Sales </a>
                                <div id="salesMenu" class="collapse submenu" style="">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/sellBooks.jsp">Sell Books</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${contextPath}/resources/view/salesReport.jsp">Sales Report </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- end left sidebar -->
        <!-- ============================================================== -->

</body>
<script src="<c:url value="/resources/js/jquery-3.3.1.min.js" />" ></script>
<script src="<c:url value="/resources/js/datatables.js" />" ></script>
<script src="<c:url value="/resources/js/jquery-ui.js" />" ></script>
<script src="<c:url value="/resources/js/bootstrap.bundle.js" />" ></script>
<script src="<c:url value="/resources/js/jquery.slimscroll.js" />" ></script>

</html>