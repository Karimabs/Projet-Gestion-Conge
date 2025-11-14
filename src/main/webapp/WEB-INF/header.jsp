<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion.conge.model.Utilisateur" %>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
%>

<header class="bg-white text-gray-800 flex justify-between items-center px-6 h-16 w-full shadow-md border-b border-gray-200">

  <h1 class="text-xl font-bold text-blue-700">Gestion des Congés</h1>

  <div class="relative">
    <button id="profileBtn" class="flex items-center gap-2 hover:bg-gray-100 px-3 py-1.5 rounded-lg transition">
      <div class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-white" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 2a4 4 0 00-4 4v1a4 4 0 008 0V6a4 4 0 00-4-4zm-6 14a6 6 0 1112 0v1H4v-1z" clip-rule="evenodd" />
        </svg>
      </div>
      <span class="font-medium text-sm text-gray-700"><%= user != null ? user.getPrenom() + " " + user.getNom() : "Invité" %></span>
    </button>

    <div id="profileMenu" class="hidden absolute right-0 mt-2 w-56 bg-white text-gray-800 rounded-lg shadow-xl border border-gray-100 p-3 z-50">
      <div class="border-b border-gray-200 pb-2 mb-2">
        <p class="font-semibold text-blue-700 text-sm"><%= user != null ? user.getPrenom() + " " + user.getNom() : "" %></p>
        <p class="text-xs text-gray-500"><%= user != null ? user.getEmail() : "" %></p>
      </div>

      <p class="text-xs mb-3 text-gray-600"><strong>Rôle :</strong> <span class="font-medium text-gray-800"><%= user != null ? user.getRole() : "" %></span></p>

      <form action="${pageContext.request.contextPath}/logout" method="post">
        <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white text-sm font-medium py-2 rounded-md transition">
          Se déconnecter
        </button>
      </form>
    </div>
  </div>
</header>

<script>
  // Ce script est déjà fonctionnel
  const btn = document.getElementById("profileBtn");
  const menu = document.getElementById("profileMenu");

  btn.addEventListener("click", () => menu.classList.toggle("hidden"));
  document.addEventListener("click", (e) => {
    if (!btn.contains(e.target) && !menu.contains(e.target)) {
      menu.classList.add("hidden");
    }
  });
</script>