<!DOCTYPE html>
<html>
<head>
    <title>BUYSELL</title>
</head>
<body>
<h1>BUYSELL</h1><hr>
<h4>Товары со всей России</h4>
<form action="/" method="get">
    Поиск по названию объявления: <input type="text" name="title"><br>
    <input type="submit" value="Поиск"/>
</form>
<#list products as product>
    <div>
        <p><b>${product.title}</b> ${product.price} руб. | <a href="/product/${product.id}">Подробнее...</a></p>
    </div>
    <#else>
    <h3>Товаров нет</h3>
</#list>
<hr>
<h3>Создать новый товар</h3>
<form action="/product/create" method="post">
    Название товара: <input type="text" name="title"/><br>
    Описание товара: <input type="text" name="description"/><br>
    Цена: <input type="number" name="price"/><br>
    Город: <input type="text" name="city"/><br>
    Автор: <input type="text" name="author"/><br>
    <input type="submit" value="Добавить товар"/>
</form>
</body>
</html>