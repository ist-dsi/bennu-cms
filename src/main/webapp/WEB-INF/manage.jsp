<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<h1><spring:message code="site.manage.title" /></h1>

<c:if test="${sites.size() != 0}">
    <p>
        <a href="#" data-toggle="modal" data-target="#defaultSite" class="btn btn-default">Set default site</a>
    </p>
</c:if>

<c:choose>
  <c:when test="${sites==null || sites.size() == 0}">
    <spring:message code="site.manage.label.emptySites" />
  </c:when>

  <c:otherwise>
    <table class="table table-striped table-bordered">
      <thead>
        <tr>
          <th class="col-md-6"><spring:message code="site.manage.label.name" /></th>
          <th><spring:message code="site.manage.label.status" /></th>
          <th><spring:message code="site.manage.label.creationDate" /></th>
          <th><spring:message code="site.manage.label.operations" /></th>
        </tr>
      </thead>
      <tbody>
      <c:forEach var="i" items="${sites}">
        <tr>
          <td>
            <c:choose>
              <c:when test="${i.getInitialPage()!=null}">
                <h5><a href="${i.getInitialPage().getAddress()}" target="_blank">${i.getName().getContent()}</a>

                    <c:if test="${i.isDefault()}">
                        <span class="label label-success"><spring:message code="site.manage.label.default"/></span>
                    </c:if>

                </h5>
              </c:when>
              <c:otherwise>
                <h5>${i.getName().getContent()}</h5>
              </c:otherwise>
            </c:choose>
            <div><small>Url: <code>${i.baseUrl}</code></small></div>
            <div><small>${i.getDescription().getContent()}</small></div>
          </td>
          <td>
              <c:choose>
                  <c:when test="${ i.published }">
                      <span class="label label-primary">Available</span>
                  </c:when>
                  <c:otherwise>
                      <span class="label label-default">Unavailable</span>
                  </c:otherwise>
              </c:choose>
          </td>
          <td><joda:format value="${i.creationDate}" pattern="MMM dd, yyyy"/></td>
          <td>
            <div class="btn-group">
              <a href="${pageContext.request.contextPath}/cms/posts/${i.slug}" class="btn btn-sm btn-default"><spring:message code="site.manage.label.posts" /></a>

              <a href="${pageContext.request.contextPath}/cms/pages/${i.slug}" class="btn btn-sm btn-default"><spring:message code="site.manage.label.pages" /></a>

              <a href="${pageContext.request.contextPath}/cms/categories/${i.slug}" class="btn btn-sm btn-default"><spring:message code="site.manage.label.categories" /></a>

              <a href="${pageContext.request.contextPath}/cms/menus/${i.slug}" class="btn btn-sm btn-default"><spring:message code="site.manage.label.menus" /></a>

              <a href="${pageContext.request.contextPath}/cms/sites/${i.slug}/edit" class="btn btn-sm btn-default"><spring:message code="action.edit" /></a>

       	      <a href="#" class="btn btn-danger btn-sm" onclick="document.getElementById('deleteSiteForm').submit();"><spring:message code="action.delete" /></a>

              <form id="deleteSiteForm" action="${pageContext.request.contextPath}/cms/sites/${i.slug}/delete" method="POST"></form>
            </div>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
    <div class="row">
        <div class="col-md-2 col-md-offset-5">
            <ul class="pagination">
                <li class="${currentPage <= 0 ? 'disabled' : 'active'}"><a href="${pageContext.request.contextPath}/cms/sites/manage/${page - 1}">«</a></li>
                <li class="disabled"><a href="#">${currentPage} / ${numberOfPages}</a></li>
                <li class="${currentPage >= numberOfPages ? 'disabled' : 'active'}"><a href="${pageContext.request.contextPath}/cms/sites/manage/${page + 1}">»</a></li>
            </ul>
        </div>
    </div>
    </c:otherwise>
</c:choose>
