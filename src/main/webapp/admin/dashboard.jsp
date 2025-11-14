<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard Admin</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-7xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">

    <h2 class="text-3xl font-bold text-gray-800 mb-6 pb-4 border-b border-gray-200">
      Gestion des utilisateurs
    </h2>

    <div class="rounded-lg border border-gray-200 overflow-x-auto mb-10">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-100">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rôle</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <c:forEach var="u" items="${users}">
            <tr>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${u.prenom} ${u.nom}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${u.email}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${u.role}</td>

              <td class="px-6 py-4 whitespace-nowrap text-sm">
                <div class="flex gap-2">
                  <a href="${pageContext.request.contextPath}/admin/dashboard?action=modifier&id=${u.id}"
                     class="bg-blue-600 text-white px-3 py-1 rounded-md text-xs font-medium
                            hover:bg-blue-700 transition-colors">
                    Modifier
                  </a>

                  <form action="${pageContext.request.contextPath}/admin/dashboard" method="post" class="inline">
                    <input type="hidden" name="id" value="${u.id}" />
                    <input type="hidden" name="action" value="supprimer" />
                    <button type="submit"
                            onclick="return confirm('Voulez-vous vraiment supprimer cet utilisateur ?');"
                            class="bg-red-600 text-white px-3 py-1 rounded-md text-xs font-medium
                                   hover:bg-red-700 transition-colors">
                      Supprimer
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <h3 class="text-2xl font-bold text-gray-800 mb-5">
      Créer un utilisateur
    </h3>
    <form action="${pageContext.request.contextPath}/admin/dashboard" method="post" class="space-y-4">

      <input type="hidden" name="action" value="creer" />

      <div class="flex flex-wrap gap-4">
        <input type="text" name="prenom" placeholder="Prénom" required
               class="flex-1 border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        <input type="text" name="nom" placeholder="Nom" required
               class="flex-1 border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        <input type="email" name="email" placeholder="Email" required
               class="flex-1 border border-gray-300 p-2 rounded-md shadow-sm ..."/>
      </div>
      <div class="flex flex-wrap gap-4">
        <input type="password" name="password" placeholder="Mot de passe" required
               class="flex-1 border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        <select name="role"
                class="flex-1 border border-gray-300 p-2 rounded-md shadow-sm bg-white ...">
          <option value="EMPLOYE">EMPLOYE</option>
          <option value="MANAGER">MANAGER</option>
          <option value="ADMIN">ADMIN</option>
        </select>
        <div class="flex-1"></div>
      </div>
      <button class="bg-blue-600 text-white px-5 py-2 rounded-md font-medium ...">
        Créer
      </button>
    </form>
  </div>
</body>
</html>