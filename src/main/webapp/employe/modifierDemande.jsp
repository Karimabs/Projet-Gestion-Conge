<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- Important pour formater les dates --%>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Modifier ma demande</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<jsp:include page="/WEB-INF/header.jsp" />

  <div class="max-w-4xl mx-auto bg-white rounded-lg shadow-lg my-12 p-8">
    <h2 class="text-3xl font-bold text-gray-800 mb-6 pb-4 border-b">
      Modifier ma demande
    </h2>

    <form action="${pageContext.request.contextPath}/employe/dashboard" method="post" class="flex flex-col gap-4">

      <input type="hidden" name="action" value="modifier" />
      <input type="hidden" name="id" value="${demande.id}" />

      <div class="flex flex-wrap items-end gap-4">
        <div>
          <label for="dateDebut" class="block text-sm font-medium text-gray-700 mb-1">Date de début</label>
          <input id="dateDebut" type="date" name="dateDebut" required
                 value="<fmt:formatDate value="${demande.dateDebut}" pattern="yyyy-MM-dd" />"
                 class="border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div>
          <label for="dateFin" class="block text-sm font-medium text-gray-700 mb-1">Date de fin</label>
          <input id="dateFin" type="date" name="dateFin" required
                 value="<fmt:formatDate value="${demande.dateFin}" pattern="yyyy-MM-DD" />"
                 class="border border-gray-300 p-2 rounded-md shadow-sm ..."/>
        </div>
        <div>
          <label for="typeConge" class="block text-sm font-medium text-gray-700 mb-1">Type de congé</label>
          <select id="typeConge" name="typeConge"
                  class="border border-gray-300 p-2 rounded-md shadow-sm bg-white ...">
            <option value="ANNUEL" <c:if test="${demande.typeConge == 'ANNUEL'}">selected</c:if>>Congé annuel</option>
            <option value="MALADIE" <c:if test="${demande.typeConge == 'MALADIE'}">selected</c:if>>Maladie</option>
            <option value="AUTRE" <c:if test="${demande.typeConge == 'AUTRE'}">selected</c:if>>Autre</option>
          </select>
        </div>
      </div>

      <div>
        <label for="note" class="block text-sm font-medium text-gray-700 mb-1">Note pour le manager (Optionnel)</label>
        <textarea id="note" name="note" rows="3"
                  class="w-full border border-gray-300 p-2 rounded-md shadow-sm ..."
                  placeholder="Ex: J'aurai un accès limité à mes emails...">${demande.note}</textarea>
      </div>

      <div class="flex gap-4 self-end">
        <a href="${pageContext.request.contextPath}/employe/dashboard"
           class="bg-gray-500 text-white px-5 py-2 rounded-md font-medium ...">
          Annuler
        </a>
        <button type="submit" class="bg-blue-600 text-white px-5 py-2 rounded-md font-medium ...">
          Enregistrer
        </button>
      </div>
    </form>
  </div>
</body>
</html>