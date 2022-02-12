<%-- 
    Document   : teams
    Created on : Jan 26, 2021, 11:17:19 AM
    Author     : Chris.Cusack
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="edu.nbcc.student.Student"%>
<%@taglib uri="/WEB-INF/tlds/studentDropdown.tld" prefix="s"%>
<%@include file="/WEB-INF/jspf/declarativemethods.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dev Teams</title>
<%@include file="/WEB-INF/jspf/header.jspf"%>
<style>
.container {
	padding: 20px;
}

.student-select {
	width: 275px;
}

.blue {
	color: blue;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/jspf/navigation.jspf"%>
	<h1>Dev Teams</h1>
	<div class="container">
		<%
		int s1 = 0;
		int s2 = 0;
		
		Student student1 = null;
		Student student2 = null;
		
		Vector<Student> team = new Vector<>();
		
		boolean submitted = false;
		
		errors = new ArrayList();
		
			if(request.getParameter("btnSubmit") != null){
				s1 = Integer.parseInt(request.getParameter("dd1"));
				s2 = Integer.parseInt(request.getParameter("dd2"));
				
				student1 = Student.getStudent(s1);
				student2 = Student.getStudent(s2);
				
				//List<List<Student>> studentTeams = new ArrayList();  
				
				Vector<Vector<Student>> studentTeams = new Vector<>();
			
				if (Student.isStudentOnTeam(team, student1)){
					errors.add("Error adding student 1");
				} else {
					team.add(student1);
				}
				
				if (Student.isStudentOnTeam(team, student2)){
					errors.add("Error adding student 2");
				} else {
					team.add(student2);
				}
				
				if (session.getAttribute("teams") != null) {
					studentTeams = (Vector<Vector<Student>>)session.getAttribute("teams");
				} else {
					studentTeams = new Vector<Vector<Student>>();
				}
				
				for (Vector<Student> t : studentTeams){
					if(Student.isStudentOnTeam(t, student1)){
						errors.add("Error adding student 1");
					}
					
					if(Student.isStudentOnTeam(t, student2)){
						errors.add("Error adding student 2");
					}
				}
				
				if (errors.isEmpty()){
					studentTeams.add(team);				
					session.setAttribute("teams", studentTeams);
				}
				
				submitted = true;
			}
		%>
		<% if (!submitted || !errors.isEmpty()){ %>
		<form method="post">
			<br /> <br /> <label>Student 1</label>
			<s:studentdropdown name="dd1" className="select 1" />
			<br /> <label>Student 2</label>
			<s:studentdropdown name="dd2" className="select 2" selectedIndex="1" />
			<br />
			<button class="btn btn-primary" name="btnSubmit">Create Team</button>
		</form>	
			<% if (!errors.isEmpty()){ %>
				<ul>
				<% for (String err: errors) { %>
					<li> <%=err %> </li>
				<% } %>
				</ul>			
			 <%} %>		
		<%	
		 } else { %>	
	</div>
	
	<table>
		<%
		for (Student student : team){
		%>
		<tr>
			<td><%=student.getId() %></td>
			<td><%=student.getFirstName() %></td>
			<td><%=student.getLastName() %></td>
		</tr>
		<% } 
		
		 }%>
	</table>
	<a href="teams.jsp">Add team</a>
	<%@include file="/WEB-INF/jspf/footer.jspf"%>
</body>
</html>
