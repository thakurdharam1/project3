\<%@page import="java.util.Map"%>
<%@page import="in.co.rays.project_3.dto.SupplierDTO"%>
<%@page import="in.co.rays.project_3.controller.SupplierListCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.rays.project_3.model.ModelFactory"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>
<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User List</title>
<script src="<%=ORSView.APP_CONTEXT%>/js/utility.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/CheckBox11.js"></script>
<style>
.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/list2.jpg');
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
	padding-top: 85px;
}

.p1 {
	padding: 4px;
	width: 200px;
	font-size: bold;
}

.text {
	text-align: center;
}
</style>

</head>
<%@include file="Header.jsp"%>
<%@include file="calendar.jsp"%>

<body class="hm">
	<div>
		<form class="pb-5" action="<%=ORSView.SUPPLIER_LIST_CTL%>"
			method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.SupplierDTO"
				scope="request"></jsp:useBean>
			<%
				List<SupplierDTO> list = (List<SupplierDTO>) ServletUtility.getList(request);
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;
				int nextPageSize = DataUtility.getInt(request.getAttribute("nextListSize").toString());
				Iterator<SupplierDTO> it = list.iterator();
			%>

			<%
				Map map = (Map) request.getAttribute("dharam");
			%>

			<%
				if (list != null && !list.isEmpty()) {
			%>
			<center>
				<h1 class="text-danger font-weight-bold pt-3">
					<u>Supplier List</u>
				</h1>
			</center>
			<div class="row">
				<div class="col-md-4"></div>
				<%
					String successMessage = ServletUtility.getSuccessMessage(request);
						if (successMessage != null && !successMessage.isEmpty()) {
				%>
				<div class="col-md-4 alert alert-success alert-dismissible"
					style="background-color: #80ff80">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="#008000"><%=successMessage%></font>
					</h4>
				</div>
				<%
					}
						String errorMessage = ServletUtility.getErrorMessage(request);
						if (errorMessage != null && !errorMessage.isEmpty()) {
				%>
				<div class="col-md-4 alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="red"><%=errorMessage%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>

			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-2">
					<input type="text" name="name" placeholder="Enter Name"
						class="form-control"
						oninput="handleLetterInput(this, 'nameError', 20)"
						onblur="validateLetterInput(this, 'nameError', 20)"
						value="<%=ServletUtility.getParameter("name", request)%>">
					<font color="red" class="pl-sm-5" id="nameError"></font>

				</div>
				&emsp;
				<div class="col-sm-2">
					<input type="text" name="paymentTerm"
						placeholder="Enter PaymentTerm"
						oninput="handleIntegerInput(this, 'paymentTermError', 7)"
						onblur="validateIntegerInput(this, 'paymentTermError', 7)"
						class="form-control"
						value="<%=ServletUtility.getParameter("paymentTerm", request)%>">
					<font color="red" class="pl-sm-5" id="paymentTermError"></font>

				</div>
				&emsp;
				<div class="col-sm-2">
					<%=HTMLUtility.getList1("category", String.valueOf(map.get(dto.getCategory())), map)%>
				</div>
				&emsp;
				<div class="col-sm-2">
					<input type="text" id="datepicker" name="date" class="form-control"
						placeholder=" Enter date" readonly="readonly"
						value="<%=ServletUtility.getParameter("date", request)%>">

				</div>
				&emsp;
				<div class="col-sm-2">
					<input type="submit" class="btn btn-primary btn-md"
						style="font-size: 15px" name="operation"
						value="<%=SupplierListCtl.OP_SEARCH%>">&emsp; <input
						type="submit" class="btn btn-dark btn-md" style="font-size: 15px"
						name="operation" value="<%=SupplierListCtl.OP_RESET%>">
				</div>
				<div class="col-sm-1"></div>
			</div>

			<br>
			<div style="margin-bottom: 20px;" class="table-responsive">
				<table class="table table-bordered table-dark table-hover">
					<thead>
						<tr style="background-color: #8C8C8C;">
							<th width="10%"><input type="checkbox" id="select_all"
								name="Select" class="text"> Select All</th>
							<th width="5%" class="text">S.NO</th>
							<th width="15%" class="text">Name</th>
							<th width="15%" class="text">PaymentTerm</th>
							<th width="20%" class="text">RegistrationDate</th>
							<th width="10%" class="text">Category</th>
							<th width="5%" class="text">Edit</th>
						</tr>
					</thead>
					<tbody>
						<%
							while (it.hasNext()) {
									dto = it.next();
						%>
						<tr>
							<td align="center"><input type="checkbox" class="checkbox"
								name="ids" value="<%=dto.getId()%>"></td>
							<td class="text"><%=index++%></td>
							<td class="text"><%=dto.getName()%></td>
							<td class="text"><%=dto.getPaymentTerm()%></td>
							<td class="text"><%=DataUtility.getDateString(dto.getDate())%></td>
							<td class="text"><%=map.get(Integer.parseInt(dto.getCategory()))%></td>

							<td class="text"><a href="SupplierCtl?id=<%=dto.getId()%>">Edit</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
			<table width="100%">
				<tr>
					<td><input type="submit" name="operation"
						class="btn btn-warning btn-md" style="font-size: 17px"
						value="<%=SupplierListCtl.OP_PREVIOUS%>"
						<%=pageNo > 1 ? "" : "disabled"%>></td>
					<td><input type="submit" name="operation"
						class="btn btn-primary btn-md" style="font-size: 17px"
						value="<%=SupplierListCtl.OP_NEW%>"></td>
					<td><input type="submit" name="operation"
						class="btn btn-danger btn-md" style="font-size: 17px"
						value="<%=SupplierListCtl.OP_DELETE%>"></td>
					<td align="right"><input type="submit" name="operation"
						class="btn btn-warning btn-md" style="font-size: 17px"
						value="<%=SupplierListCtl.OP_NEXT%>"
						<%=(nextPageSize != 0) ? "" : "disabled"%>></td>
				</tr>
			</table>

			<%
				} else {
			%>
			<center>
				<h1 style="font-size: 40px; color: #162390;">Product List</h1>
			</center>
			<br>
			<div class="row">
				<div class="col-md-4"></div>
				<%
					if (!ServletUtility.getErrorMessage(request).equals("")) {
				%>
				<div class="col-md-4 alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>
			<br>
			<div style="padding-left: 48%;">
				<input type="submit" name="operation" class="btn btn-primary btn-md"
					style="font-size: 17px" value="<%=SupplierListCtl.OP_BACK%>">
			</div>
			<%
				}
			%>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
		</form>
	</div>
</body>
<%@include file="FooterView.jsp"%>
</html>
