<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BUYSELL - Подробная информация о товаре</title>
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
            max-width: 600px;
            margin: auto;
        }
        .product-image {
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            display: inline-block;
        }
        .product-info {
            margin: 15px 0;
        }
        b {
            color: #555;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }
        a:hover {
            color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>BUYSELL</h1>
        <hr>
        <h4>Подробная информация о товаре</h4>

        <#list images as img>
            <img src="/images/${img.id}" alt="Изображение товара" class="product-image" height="60px"/>
        </#list>

        <div class="product-info">
            <p><b>Название товара:</b> ${product.title}</p>
            <p><b>Описание товара:</b> ${product.description}</p>
            <p><b>Цена товара:</b> ${product.price} руб.</p>
            <p><b>Город:</b> ${product.city}</p>
            <p><b>Автор:</b> <a href="/user/${product.user.id}">${product.user.name}</a></p>
        </div>

        <form action="/product/delete/${product.id}" method="post" onsubmit="return confirm('Вы уверены, что хотите удалить этот товар?');">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit">Удалить товар</button>
        </form>
    </div>
</body>
</html>