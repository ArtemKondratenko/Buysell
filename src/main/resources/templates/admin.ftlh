<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BUYSELL - Панель администратора</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #333;
        }
        h4 {
            color: #555;
        }
        hr {
            border: 1px solid #ccc;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            text-decoration: none;
            color: #4CAF50;
            padding: 5px 10px;
            border: 1px solid #4CAF50;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #4CAF50;
            color: white;
        }
        button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #d32f2f;
        }
        .no-users {
            text-align: center;
            color: #777;
        }
    </style>
</head>
<body>
    <h1>BUYSELL</h1>
    <hr>
    <h4>Панель администратора</h4>
    <table>
        <tr>
            <th>Email</th>
            <th>Номер телефона</th>
            <th>Активность</th>
            <th>Роли</th>
            <th>Бан</th>
            <th>Редактирование</th>
            <th>Подробная информация</th>
        </tr>
        <#if users?has_content>
            <#list users as user>
                <tr>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <td><#if user.active>true<#else>false</#if></td>
                    <td>
                        <#list user.roles as role>
                            ${role}<#if role_has_next>, </#if>
                        </#list>
                    </td>
                    <td>
                        <form action="/admin/user/ban/${user.id}" method="post" style="display:inline;">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit">Бан</button>
                        </form>
                    </td>
                    <td><a href="/admin/user/edit/${user.id}">Редактирование</a></td>
                    <td><a href="/user/${user.id}">Подробная информация</a></td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="7" class="no-users"><h3>Пользователей нет</h3></td>
            </tr>
        </#if>
    </table>
</body>
</html>