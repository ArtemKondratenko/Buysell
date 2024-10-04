<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BUYSELL - Регистрация</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        h4 {
            color: #555;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: auto;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>BUYSELL</h1>
    <hr>
    <div class="container">
        <h4>Регистрация</h4>
        <form action="/registration" method="post">
            <input type="text" name="name" placeholder="Имя пользователя" required>
            <input type="email" name="email" placeholder="Эл. почта" required>
            <input type="text" name="phoneNumber" placeholder="Номер телефона" required>
            <input type="password" name="password" placeholder="Пароль" required>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Зарегистрироваться"/>
        </form>
        <#if errorMessage??>
            <h2 class="error-message">${errorMessage}</h2>
        </#if>
    </div>
</body>
</html>