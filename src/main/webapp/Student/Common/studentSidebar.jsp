<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="studentHome.jsp">
        <div class="sidebar-brand-icon">
            <i class="fas fa-school"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Student Home</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="studentHome.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Home</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading - Management -->
    <div class="sidebar-heading">
        Management
    </div>

    <!-- Nav Item - Welfare Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseWelfare" aria-expanded="true" aria-controls="collapseWelfare">
            <i class="fas fa-fw fa-book"></i>
            <span>Welfare Tools</span>
        </a>
        <div id="collapseWelfare" class="collapse" aria-labelledby="headingWelfare" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="findDegreePath.jsp">Degree Path</a>
                <a class="collapse-item" href="personalityTraits.jsp">Personality Traits</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Courses Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCourses" aria-expanded="true" aria-controls="collapseCourses">
            <i class="fas fa-fw fa-book"></i>
            <span>Courses</span>
        </a>
        <div id="collapseCourses" class="collapse" aria-labelledby="headingCourses" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="courses.jsp">All Courses</a>
                <a class="collapse-item" href="enrolledCourses.jsp">Enrolled Course</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Results Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseStudents" aria-expanded="true" aria-controls="collapseStudents">
            <i class="fas fa-fw fa-user-graduate"></i>
            <span>Results</span>
        </a>
        <div id="collapseStudents" class="collapse" aria-labelledby="headingStudents" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="pendingResults.jsp">Pending Results</a>
                <a class="collapse-item" href="releasedResults.jsp">Released Results</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Assignments Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseInstructors" aria-expanded="true" aria-controls="collapseInstructors">
            <i class="fas fa-fw fa-chalkboard-teacher"></i>
            <span>Assignments</span>
        </a>
        <div id="collapseInstructors" class="collapse" aria-labelledby="headingInstructors" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="pendingAssignments.jsp">Pending Assignments</a>
                <a class="collapse-item" href="submittedAssignments.jsp">Submitted Assignments</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Reports -->
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link" href="reports.jsp">--%>
<%--            <i class="fas fa-fw fa-chart-line"></i>--%>
<%--            <span>Reports</span>--%>
<%--        </a>--%>
<%--    </li>--%>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

    <!-- Logout -->
    <li class="nav-item">
        <a class="nav-link" href="../logout.jsp">
            <i class="fas fa-fw fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </li>
</ul>
<!-- End of Sidebar -->
