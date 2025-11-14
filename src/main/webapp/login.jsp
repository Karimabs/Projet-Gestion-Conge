<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Connexion - Gestion congés</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
  <div class="w-full max-w-md bg-white p-8 rounded shadow">
    <h1 class="text-2xl font-bold mb-6 text-center">Connexion</h1>

    <c:if test="${not empty error}">
      <div class="bg-red-100 text-red-700 p-2 rounded mb-4">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
      <div>
        <label class="block text-sm font-medium">Email</label>
        <input type="email" name="email" required class="w-full border rounded px-3 py-2" />
      </div>
      <div>
        <label class="block text-sm font-medium">Mot de passe</label>
        <input type="password" name="password" required class="w-full border rounded px-3 py-2" />
      </div>
      <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded">Se connecter</button>
    </form>
  </div>
</body>
</html>
