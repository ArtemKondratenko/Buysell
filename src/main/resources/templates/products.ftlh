<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BUYSELL</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        h3, h4 {
            color: #555;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .user-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .user-info img {
            border-radius: 50%;
            width: 80px;
            height: 80px;
            margin-right: 15px;
        }
        .logout-form {
            display: inline;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            color: #45a049;
        }
        input[type="text"], input[type="number"], input[type="file"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
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
        .product {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .no-products {
            text-align: center;
            color: #777;
            margin: 20px 0;
        }
        .search-form {
            margin: 20px 0;
            text-align: center;
        }
        .search-form input[type="text"] {
            width: 70%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>BUYSELL</h1>
        <#if user.email??>
            <div class="user-info">
                <div>
                    <img src="${avatarUrl}" alt="Аватарка пользователя">
                    <h3>Имя пользователя: <i>${user.name}</i></h3>
                </div>
                <form action="/logout" method="post" class="logout-form">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Выйти"/>
                </form>
            </div>
            <#if user.isAdmin()>
                <a href="/admin">Панель администратора</a>
            </#if>
        <#else>
            <a href="/login">Войти</a>
        </#if>
        <hr>

        <h4>Товары со всей России</h4>
        <div class="search-form">
            <form action="/" method="get">
                Поиск по названию объявления:
                <input type="text" name="title" placeholder="Введите название">
                <input type="submit" value="Поиск"/>
            </form>
        </div>

        <#if products?has_content>
            <#list products as product>
                <div class="product">
                    <p><b>${product.title}</b> - ${product.price} руб. | <a href="/product/${product.id}">Подробнее...</a></p>
                </div>
            </#list>
        <#else>
            <h3 class="no-products">Товаров нет</h3>
        </#if>

        <#if user.email??>
            <hr>
            <h3>Создать новый товар</h3>
            <form action="/product/create" method="post" enctype="multipart/form-data">
                <input type="text" name="title" placeholder="Название товара" required/>
                <input type="text" name="description" placeholder="Описание товара" required/>
                <input type="number" name="price" placeholder="Цена" required/>
                <input type="text" name="city" placeholder="Город" required/>
                <input type="file" name="files" multiple required/>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Добавить товар"/>
            </form>
        </#if>
    </div>
</body>
</html>