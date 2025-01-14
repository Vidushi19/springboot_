<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pending Sellers</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$(document)
								.on(
										'click',
										'.activate',
										function(e) {
											e.preventDefault();
											var aid = $(this).parent().parent()
													.data('id');
											//alert(aid);
											$
													.ajax({
														url : 'activateSeller.htm',
														contentType : "application/json; charset=utf-8",
														data : {
															'aid' : aid
														},
														type : 'GET',
														cache : false,
														success : function(
																response) {
																$("#row-"+response).fadeOut();														
														}
													});
										});
					});
</script>
</head>
<body>
	<%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
            String role = (String) session.getAttribute("role");
            if (role == "admin") {
    %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<a href="${contextPath}/logout.htm">Logout</a>
	<!-- <a href="${contextPath}/admin/view-sellers.htm">Go back</a> -->
	<h1>List of Pending Sellers</h1>
	<c:choose>
		<c:when test="${!empty sellers}">
			<table id="table" border="1" cellpadding="5">
				<tr>
					<th>Company Name</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email ID</th>
					<th>Phone Number</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
				<c:forEach var="seller" items="${sellers}">
					<tr id="row-${seller.personID}" data-id="${seller.personID}">
						<td>${seller.companyName}</td>
						<td>${seller.firstName}</td>
						<td>${seller.lastName}</td>
						<td>${seller.email.emailAddress}</td>
						<td>${seller.phone.phoneNo}</td>
						<td class="status_${seller.personID}">Pending</td>
						<td class="action_${seller.personID}"><a href="#"
							class="activate">Activate Seller</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
			<c:out value="No Pending Sellers" />
		</c:otherwise>
	</c:choose>
	<%
            }
	%>
</body>
</html>