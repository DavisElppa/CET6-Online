<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>管理员界面</title>
    <script>
        function showTab(tabName) {
            var tabs = document.getElementsByClassName("tab");
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].style.display = "none";
            }
            document.getElementById(tabName).style.display = "block";
        }
    </script>
    <!-- Bootstrap 的 CSS 文件 -->
    <c:set var="path" value="${pageContext.request.contextPath}" scope="page"/>
    <link rel="stylesheet" href="${path}/resource/bootstrap/css/bootstrap.css">
    <style>

        .sidebar {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .sidebar button {
            flex-grow: 1;
            margin-bottom: 10px;
        }

        .tab {
            display: none;
        }

        body {
            background-color: #a6e1e2;
            /*font-family: Arial, sans-serif;*/
            /*display: flex;*/
            /*justify-content: center;*/
            /*align-items: center;*/
        }
        .navbar {
            background-color: #30679a;
            color: white;
            width: 100%; /* Set the desired width */
            height: 80px;
        }
        .navbar-brand {
            color: white;
            margin-left: 10px;
        }
        .navbar-text {
            color: white;
            margin-right: 10px;
        }
        .logo-img {
            width: 480px;
            height: 80px;
        }

        .container {
            width: 100%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            border-collapse: collapse;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            /* 添加右侧边距 */
        }

        input[type="submit"]:hover,
        input[type="button"]:hover {
            background-color: #45a049;
        }

        th, td {
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            style: "overflow-x: auto; white-space: nowrap;";
            background-color: lightyellow;
        }

        th, td:hover {
            background-color: #f5f5f5;
        }

        button {
            padding: 10px 20px; /* 自定义按钮的内边距 */
            font-size: 30px; /* 自定义按钮的字体大小 */
        }

        .sidebar-container {
            display: flex;
            justify-content: center;
        }
    </style>
</head>

<body>

<nav class="navbar">
    <div class="container-fluid">
        <span class="navbar-brand" style="font-size: 32px; text-align: center; line-height: 50px; margin-left: 490px;">管理员界面</span>
        <span class="navbar-text ml-auto" style="font-size: 20px; text-align: center; line-height: 50px; margin-left: 1040px;">欢迎，XX管理员</span>
    </div>
</nav>

<div style="position: absolute; top: 0; left: 0;">
    <img src="${path}/resource/picture/logo.jpg" alt="Icon" class="logo-img">
</div>

<div class="sidebar-container">
    <div class="sidebar">
        <button onclick="showTab('exam')">考试信息管理</button>
        <button onclick="showTab('teacher')">教师信息管理</button>
        <button onclick="showTab('student')">学生信息管理</button>
    </div>
</div>

<div id="exam" class="tab">
    <h2>考试信息管理</h2>

    <!-- 添加考试信息按钮 -->
    <div class="text-center">
        <button type="button" class="btn btn-primary mx-auto" data-toggle="modal" data-target="#addExamModal">
            添加考试信息
        </button>
    </div>

    <!-- 考试信息列表 -->
    <table class="table">
        <thead>
        <tr>
            <th>考试ID</th>
            <th>考试名称</th>
            <th>考试日期</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 使用JSP标签循环遍历考试信息 -->
        <c:forEach var="exam" items="${examList}">
            <tr>
                <td>${exam.id}</td>
                <td contenteditable="true"
                    onblur="updateExamInfo('${exam.id}', 'examName', this.innerText)">${exam.name}
                </td>
                <td contenteditable="true"
                    onblur="updateExamInfo('${exam.id}', 'examDate', this.innerText)">
                        ${exam.date}</td>
                <td>
                    <!-- 删除考试信息按钮 -->
                    <button type="button" class="btn btn-danger"
                            onclick="deleteExamInfo('${exam.id}')">
                        删除
                    </button>
                    <!-- 查看考试信息按钮 TODO -->
                    <button type="button" class="btn btn-success">
                        查看
                    </button>
                </td>
            </tr>
        </c:forEach>

        <script type="text/javascript">
            function updateExamInfo(examId, field, new_value) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=updateExam&examId=" + examId + "&" + field + "=" + new_value;
                // alert("exam " + examId + " 更改成功！");
            }

            function deleteExamInfo(examId) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=deleteExam&examId=" + examId;
                alert("exam " + examId + " 删除成功！");
            }
        </script>

        </tbody>
    </table>
</div>

<div id="teacher" class="tab">
    <h2>教师信息管理</h2>

    <!-- 添加教师信息按钮 -->
    <div class="text-center">
        <button type="button" class="btn btn-primary mx-auto" data-toggle="modal"
                data-target="#addTeacherModal">
            添加教师信息
        </button>
    </div>

    <!-- 教师信息列表 -->
    <table class="table">
        <thead>
        <tr>
            <th>教师ID</th>
            <th>姓名</th>
            <th>性别</th>
            <th>Email</th>
            <th>Tel</th>
            <th>Password</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 使用JSP标签循环遍历教师信息 -->
        <c:forEach var="teacher" items="${teacherList}">
            <tr>
                <td>${teacher.id}</td>
                <td contenteditable="true"
                    onblur="updateTeacherInfo('${teacher.id}', 'teacherName', this.innerText)">
                        ${teacher.name}</td>
                <td contenteditable="true"
                    onblur="updateTeacherInfo('${teacher.id}', 'teacherGender', this.innerText)">
                        ${teacher.gender}</td>
                <td contenteditable="true"
                    onblur="updateTeacherInfo('${teacher.id}', 'teacherEmail', this.innerText)">
                        ${teacher.email}</td>
                <td contenteditable="true"
                    onblur="updateTeacherInfo('${teacher.id}', 'teacherTel', this.innerText)">
                        ${teacher.tel}</td>
                <td contenteditable="true"
                    onblur="updateTeacherInfo('${teacher.id}', 'teacherPassword', this.innerText)">
                        ${teacher.password}</td>
                <td>
                    <!-- 删除教师信息按钮 -->
                    <button type="button" class="btn btn-danger"
                            onclick="deleteTeacherInfo('${teacher.id}')">
                        删除
                    </button>
                </td>
            </tr>
        </c:forEach>

        <script type="text/javascript">
            function updateTeacherInfo(teacherId, field, new_value) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=updateTeacher&teacherId=" + teacherId + "&" + field + "=" + new_value;
                // alert("teacher " + teacherId + " 更改成功！");
            }

            function deleteTeacherInfo(teacherId) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=deleteTeacher&teacherId=" + teacherId;
                alert("teacher " + teacherId + " 删除成功！");
            }
        </script>

        </tbody>
    </table>
</div>

<div id="student" class="tab">
    <h2>学生信息管理</h2>

    <!-- 添加学生信息按钮 -->
    <div class="text-center">
        <button type="button" class="btn btn-primary mx-auto" data-toggle="modal"
                data-target="#addStudentModal">
            添加学生信息
        </button>
    </div>

    <!-- 学生信息列表 -->
    <table class="table">
        <thead>
        <tr>
            <th>学生ID</th>
            <th>姓名</th>
            <th>性别</th>
            <th>Email</th>
            <th>Tel</th>
            <th>Password</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 使用JSP标签循环遍历学生信息 -->
        <c:forEach var="student" items="${studentList}">
            <tr>
                <td>${student.id}</td>
                <td contenteditable="true"
                    onblur="updateStudentInfo('${student.id}', 'studentName', this.innerText)">
                        ${student.name}</td>
                <td contenteditable="true"
                    onblur="updateStudentInfo('${student.id}', 'studentGender', this.innerText)">
                        ${student.gender}</td>
                <td contenteditable="true"
                    onblur="updateStudentInfo('${student.id}', 'studentEmail', this.innerText)">
                        ${student.email}</td>
                <td contenteditable="true"
                    onblur="updateStudentInfo('${student.id}', 'studentTel', this.innerText)">
                        ${student.tel}</td>
                <td contenteditable="true"
                    onblur="updateStudentInfo('${student.id}', 'studentPassword', this.innerText)">
                        ${student.password}</td>
                <td>
                    <!-- 删除学生信息按钮 -->
                    <button type="button" class="btn btn-danger"
                            onclick="deleteStudentInfo('${student.id}')">
                        删除
                    </button>
                </td>
            </tr>
        </c:forEach>

        <script type="text/javascript">
            function updateStudentInfo(studentId, field, new_value) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=updateStudent&studentId=" + studentId + "&" + field + "=" + new_value;
                // alert("student " + studentId + " 更改成功！");
            }

            function deleteStudentInfo(studentId) {
                location.href = "${path}/CET6/admin.do?userId=${userId}&userPassword=${userPassword}&action=deleteStudent&studentId=" + studentId;
                alert("student " + studentId + " 删除成功！");
            }
        </script>

        </tbody>
    </table>
</div>

<script type="text/javascript" src="${path}/resource/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="${path}/resource/bootstrap/js/bootstrap.js"></script>

</body>

</html>
```