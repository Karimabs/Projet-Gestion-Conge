<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Historique des demandes - Manager</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-7xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">

    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-200">
      <h2 class="text-3xl font-bold text-gray-800">
        Historique des demandes
      </h2>
      <a href="${pageContext.request.contextPath}/manager/dashboard"
         class="bg-blue-600 text-white px-5 py-2 rounded-md font-medium
                hover:bg-blue-700 transition-colors
                focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
        &larr; Retour aux validations
      </a>
    </div>

    <form action="${pageContext.request.contextPath}/manager/historique" method="get" class="mb-6">
      <div class="flex">
        <input type="text" name="recherche"
               class="flex-grow border border-gray-300 p-2 rounded-l-md shadow-sm
                      focus:outline-none focus:ring-2 focus:ring-blue-500"
               placeholder="Rechercher par nom ou prénom d'employé..."
               value="${param.recherche}"> <%-- Garde le terme recherché dans la barre --%>

        <button type="submit"
                class="bg-gray-700 text-white px-5 py-2 rounded-r-md font-medium
                       hover:bg-gray-800 transition-colors
                       focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2">
          Rechercher
        </button>
      </div>
    </form>

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
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <c:forEach var="d" items="${demandesHistorique}">
            <tr>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${d.utilisateur.prenom} ${d.utilisateur.nom}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateDebut}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateFin}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.typeConge}</td>
              <td class="px-6 py-4 text-sm text-gray-600 max-w-sm whitespace-normal">
                <c:if test="${not empty d.note}">${d.note}</c:if>
                <c:if test="${empty d.note}"><span class="text-gray-400">--</span></c:if>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <c:choose>
                  <c:when test="${d.statut == 'ACCEPTEE'}">
                    <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                      Acceptée
                    </span>
                  </c:when>
                  <c:when test="${d.statut == 'REFUSEE'}">
                    <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                      Refusée
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                      ${d.statut}
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty demandesHistorique}">
            <tr>
              <td colspan="6" class="px-6 py-4 text-center text-gray-500">
                Aucune demande trouvée
                <c:if test="${not empty param.recherche}">
                  pour la recherche : "${param.recherche}"
                </c:if>
              </td>
            </tr>
          </c:if>

        </tbody>
      </table>
    </div>
  </div>
</body>
</html>