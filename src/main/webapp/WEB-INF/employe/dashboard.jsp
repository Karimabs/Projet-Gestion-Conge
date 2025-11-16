<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.gestion.conge.model.Utilisateur" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard Employé</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-6xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">
    <%
      Utilisateur user = (Utilisateur) session.getAttribute("user");
    %>
    <h2 class="text-3xl font-bold text-gray-800 mb-6">
      Bienvenue, <%= user != null ? user.getPrenom() + " " + user.getNom() : "Invité" %>
    </h2>

    <h3 class="text-2xl font-bold text-gray-800 mb-5 pb-3 border-b border-gray-200">
      Mes demandes
    </h3>
    <div class="rounded-lg border border-gray-200 overflow-x-auto mb-10">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-100">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date début</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date fin</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <c:forEach var="d" items="${demandes}">
            <tr>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateDebut}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.dateFin}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${d.typeConge}</td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${d.statut}</td>

              <td class="px-6 py-4 whitespace-nowrap text-sm">
                <c:if test="${d.statut == 'EN_ATTENTE'}">
                  <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/employe/dashboard?action=modifier&id=${d.id}"
                       class="bg-blue-600 text-white px-3 py-1 rounded-md text-xs font-medium
                              hover:bg-blue-700 transition-colors">
                      Modifier
                    </a>

                    <form action="${pageContext.request.contextPath}/employe/dashboard" method="post" class="inline">
                      <input type="hidden" name="id" value="${d.id}" />
                      <input type="hidden" name="action" value="annuler" />
                      <button type="submit"
                              class="bg-red-600 text-white px-3 py-1 rounded-md text-xs font-medium
                                     hover:bg-red-700 transition-colors">
                        Annuler
                      </button>
                    </form>
                  </div>
                </c:if>

                <c:if test="${d.statut != 'EN_ATTENTE'}">
                  <span class="text-gray-400">--</span>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <h3 class="text-2xl font-bold text-gray-800 mb-5">
      Nouvelle demande
    </h3>
    <form action="${pageContext.request.contextPath}/employe/dashboard" method="post" class="flex flex-col gap-4 p-4 bg-gray-50 rounded-lg border">

      <input type="hidden" name="action" value="envoyer" />

      <div class="flex flex-wrap items-end gap-4">
        <div>
          <label for="dateDebut" class="block text-sm font-medium text-gray-700 mb-1">Date de début</label>
          <input id="dateDebut" type="date" name="dateDebut" required
                 class="border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div>
          <label for="dateFin" class="block text-sm font-medium text-gray-700 mb-1">Date de fin</label>
          <input id="dateFin" type="date" name="dateFin" required
                 class="border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div>
          <label for="typeConge" class="block text-sm font-medium text-gray-700 mb-1">Type de congé</label>
          <select id="typeConge" name="typeConge"
                  class="border border-gray-300 p-2 rounded-md shadow-sm bg-white ...">
            <option value="ANNUEL">Congé annuel</option>
            <option value="MALADIE">Maladie</option>
            <option value="AUTRE">Autre</option>
          </select>
        </div>
      </div>

      <div>
        <label for="note" class="block text-sm font-medium text-gray-700 mb-1">Note pour le manager (Optionnel)</label>
        <textarea id="note" name="note" rows="3"
                  class="w-full border border-gray-300 p-2 rounded-md shadow-sm ..."
                  placeholder="Ex: J'aurai un accès limité à mes emails..."></textarea>
      </div>

      <div class="self-end">
        <button type="submit" class="bg-green-600 text-white px-5 py-2 rounded-md font-medium ...">
          Envoyer
        </button>
      </div>
    </form>
  </div>
</body>
</html>