<%@page import="java.net.URLEncoder"%>
<%@page import="f201632025.Book"%>
<%@page import="java.util.List"%>
<%@page import="f201632025.BookDAO"%>
<%@page import="f201632025.ParseUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%
	int currentPage = 1;
	int pageSize = 10;
	
	request.setCharacterEncoding("UTF-8");
	
	String pg = request.getParameter("pg");
	if (pg != null) currentPage = ParseUtils.parseInt(pg, 1);
	String ss = "0";
	String st = null;
	
	int recordCount = BookDAO.count();

	int lastPage = Math.max(1, (recordCount + pageSize - 1) / pageSize);
	if (currentPage > lastPage) currentPage = lastPage;

	List<Book> list = BookDAO.findAll(currentPage, pageSize, ss, st);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"content="text/html; charset=utf-8">
<meta name="viewport"content="width=device-width, initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
body { font-family: 굴림체; }
thead th { background-color: #eee; }
tr:hover td { background-color: #ffe; cursor: pointer; }
table.table { margin-top: 5px; }
select[name=od] { margin-right: 20px; }
</style>
</head>
<body>
<div class="container">
	<h1>책 목록</h1>
	
<table class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th>ID</th>
				<th>제목</th>
				<th>저자</th>
				<th>카테고리</th>
				<th>가격</th>
				<th>대여가능</th>
			</tr>
		</thead>
		<tbody>
			<%for (Book book : list) { %>
			<tr data-url="edit3.jsp?id=<%=book.getId()%>&pg=<%=currentPage%>">
				<td><%= book.getId() %></td>
				<td><%= book.getTitle() %></td>
				<td><%= book.getAuthor()%></td>
				<td><%= book.getCategoryName() %></td>
				<td><%= book.getPrice() %></td>
				<td><%= book.isAvailable() ? "0" : "" %></td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<my:pagination pageSize="<%= pageSize %>" recordCount="<%= recordCount %>" queryStringName="pg"/>
</div>
<script>
	$("[data-url]").click(function() {
	var url = $(this).attr("data-url");
    location.href = url;
	})
</script>
</body>
</html>