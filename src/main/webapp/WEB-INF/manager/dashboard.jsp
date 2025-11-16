<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard Manager</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-7xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">

    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-200">
      <h2 class="text-3xl font-bold text-gray-800">
        Validation des demandes
      </h2>
      <a href="${pageContext.request.contextPath}/manager/historique"
         class="bg-gray-600 text-white px-5 py-2 rounded-md font-medium
                hover:bg-gray-700 transition-colors
                focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2">
        Voir l'historique
      </a>
    </div>

    <div class="rounded-lg border border-gray-200 overflow-x-auto">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-100">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Employé</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date début</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date fin</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Note</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <c:forEach var="d" items="${demandes}">
            <tr>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${d.utilisateur.prenom} ${d.utilisateur.nom}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateDebut}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateFin}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.typeConge}</td>
              <td class="px-6 py-4 text-sm text-gray-600 max-w-sm whitespace-normal">
                <c:if test="${not empty d.note}">${d.note}</c:if>
                <c:if test="${empty d.note}"><span class="text-gray-400">--</span></c:if>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${d.statut}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm">
                <form action="${pageContext.request.contextPath}/manager/dashboard" method="post" class="inline-flex gap-2">
                  <input type="hidden" name="id" value="${d.id}"/>
                  <button name="action" value="accepter"
                          class="bg-green-100 text-green-800 px-3 py-1 rounded-md text-xs font-medium
                                 hover:bg-green-200 transition-colors">
                    Accepter
                  </button>
                  <button name="action" value="refuser"
                          class="bg-red-100 text-red-800 px-3 py-1 rounded-md text-xs font-medium
                                 hover:bg-red-200 transition-colors">
                    Refuser
                  </button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>