<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BUYSELL - Подробная информация о пользователе</title>
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
        h3 {
            color: #555;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }
        .user-info {
            margin-bottom: 20px;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .product {
            margin: 10px 0;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            color: #45a049;
        }
        .avatar-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .avatar-container img {
            border-radius: 50%;
            width: 80px;
            height: 80px;
            margin-right: 15px;
        }
        input[type="file"] {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>BUYSELL</h1>
    <hr>
    <div class="container">
        <h3>Подробная информация о пользователе <i>${user.name}</i></h3>
       <div class="avatar-container">
           <#if avatarUrl??>
               <img src="${avatarUrl}" alt="Аватарка пользователя">
           <#else>
               <img src="/static/default-avatar.png" alt="Аватарка пользователя">
           </#if>
           <form action="/user/upload-avatar" method="post" enctype="multipart/form-data">
               <input type="file" name="file" required />
               <input type="hidden" value="${user.id}" name="userId">
               <input type="hidden" value="${_csrf.token}" name="_csrf">
               <button type="submit">Загрузить аватар</button>
           </form>
       </div>
        <div class="user-info">
            <p><b>Номер телефона:</b> ${user.phoneNumber}</p>
            <p><b>Электронная почта:</b> ${user.email}</p>
        </div>
        <h4>Товары пользователя <i>${user.name}</i></h4>
        <#if products?has_content>
            <#list products as product>
                <div class="product">
                    <p><b>${product.title}</b> ${product.price} руб. | <a href="/product/${product.id}">Подробнее...</a></p>
                </div>
            </#list>
        <#else>
            <h3>Товаров нет</h3>
        </#if>
        <#if errorMessage??>
            <h2 class="error-message">${errorMessage}</h2>
        </#if>
    </div>
</body>
</html>