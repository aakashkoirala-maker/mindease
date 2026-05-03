<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Counselors - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Manage Counselors</h1>
                <p>Add, update, and manage counselor availability.</p>
            </div>

            <c:if test="${param.success == 'true'}"><div class="alert-success">Saved successfully.</div></c:if>
            <c:if test="${param.error == 'true'}"><div class="alert-error">Action failed.</div></c:if>

            <div class="admin-two-col-wide">
                <div class="form-card">
                    <div class="panel-title">${not empty editCounselor ? 'Edit Counselor' : 'Add Counselor'}</div>
                    <form method="post" action="${pageContext.request.contextPath}/admin/counselors">
                        <input type="hidden" name="action" value="${not empty editCounselor ? 'update' : 'create'}">
                        <c:if test="${not empty editCounselor}">
                            <input type="hidden" name="counselorId" value="${editCounselor.counselorId}">
                        </c:if>
                        <div class="form-group">
                            <label>Name</label>
                            <input class="form-control" name="name" required value="${editCounselor.name}">
                        </div>
                        <div class="form-group">
                            <label>Specialization</label>
                            <input class="form-control" name="specialization" placeholder="e.g. Anxiety, Depression" value="${editCounselor.specialization}">
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input class="form-control" name="email" type="email" value="${editCounselor.email}">
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input class="form-control" name="phone" value="${editCounselor.phone}">
                        </div>
                        <div class="form-group">
                            <label>Available Days</label>
                            <input class="form-control" name="availableDays" placeholder="e.g. Mon, Wed, Fri" value="${editCounselor.availableDays}">
                        </div>
                        <div class="form-group">
                            <label>Status</label>
                            <select class="form-control" name="status">
                                <option value="active" ${editCounselor.status == 'active' ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${editCounselor.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <button class="btn btn-primary" type="submit" style="width:100%; padding:11px; border-radius:8px; font-weight:600;">
                            ${not empty editCounselor ? 'Update Counselor' : 'Add Counselor'}
                        </button>
                        <c:if test="${not empty editCounselor}">
                            <a class="btn btn-outline" style="width:100%; margin-top:10px; text-align:center; display:block;" href="${pageContext.request.contextPath}/admin/counselors">Cancel</a>
                        </c:if>
                    </form>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h2>All Counselors</h2>
                    </div>
                    <div class="table-responsive">
                        <table class="admin-two-col-wide-table">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Specialization</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Available Days</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="c" items="${counselors}">
                                <tr>
                                    <td style="font-weight:600;">${c.name}</td>
                                    <td>
                                        <span class="text-truncate" style="max-width:150px; display:block;" title="${c.specialization}">${c.specialization}</span>
                                    </td>
                                    <td>${c.email}</td>
                                    <td>${c.phone}</td>
                                    <td>
                                        <div style="display:flex; flex-wrap:wrap; gap:4px;">
                                            <c:forEach var="day" items="${fn:split(c.availableDays, ',')}">
                                                <span class="days-pill">${fn:trim(day)}</span>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td><span class="badge ${c.status == 'active' ? 'badge-active' : 'badge-inactive'}">${c.status}</span></td>
                                    <td>
                                        <div class="actions-stack">
                                            <a class="btn-edit" href="${pageContext.request.contextPath}/admin/counselors?editId=${c.counselorId}">Edit</a>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/counselors">
                                                <input type="hidden" name="action" value="${c.status == 'active' ? 'deactivate' : 'activate'}">
                                                <input type="hidden" name="counselorId" value="${c.counselorId}">
                                                <button class="btn ${c.status == 'active' ? 'btn-warning' : 'btn-success'}" type="submit" style="width:100%">
                                                        ${c.status == 'active' ? 'Deactivate' : 'Activate'}
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>