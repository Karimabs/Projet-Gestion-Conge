<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Modifier Utilisateur</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 pb-4 border-b">
      Modifier l'utilisateur : ${utilisateur.prenom} ${utilisateur.nom}
    </h2>

    <form action="${pageContext.request.contextPath}/admin/dashboard" method="post" class="space-y-4">

      <input type="hidden" name="action" value="sauvegarder" />
      <input type="hidden" name="id" value="${utilisateur.id}" />

      <div class="flex flex-wrap gap-4">
        <div class="flex-1">
          <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
          <input id="prenom" type="text" name="prenom" required value="${utilisateur.prenom}"
                 class="mt-1 w-full border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div class="flex-1">
          <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
          <input id="nom" type="text" name="nom" required value="${utilisateur.nom}"
                 class="mt-1 w-full border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
      </div>

      <div>
        <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
        <input id="email" type="email" name="email" required value="${utilisateur.email}"
               class="mt-1 w-full border border-gray-300 p-2 rounded-md shadow-sm ..."/>
      </div>

      <div class="flex flex-wrap gap-4">
        <div class="flex-1">
          <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
          <input id="password" type="password" name="password"
                 placeholder="Laisser vide pour ne pas changer"
                 class="mt-1 w-full border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div class="flex-1">
          <label for="role" class="block text-sm font-medium text-gray-700">Rôle</label>
          <select id="role" name="role"
                  class="mt-1 w-full border border-gray-300 p-2 rounded-md shadow-sm bg-white ...">
            <option value="EMPLOYE" <c:if test="${utilisateur.role == 'EMPLOYE'}">selected</c:if>>EMPLOYE</option>
            <option value="MANAGER" <c:if test="${utilisateur.role == 'MANAGER'}">selected</c:if>>MANAGER</option>
            <option value="ADMIN" <c:if test="${utilisateur.role == 'ADMIN'}">selected</c:if>>ADMIN</option>
          </select>
        </div>
      </div>

      <div class="flex gap-4 self-end pt-4">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="bg-gray-500 text-white px-5 py-2 rounded-md font-medium ...">
          Annuler
        </a>
        <button type="submit" class="bg-blue-600 text-white px-5 py-2 rounded-md font-medium ...">
          Sauvegarder
        </button>
      </div>
    </form>
  </div>
</body>
</html>