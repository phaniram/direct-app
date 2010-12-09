<%--
  - Author: TCSDEVELOPER
  - Version: 1.0
  - Copyright (C) 2010 TopCoder Inc., All Rights Reserved.
  -
  - Description: This page renders the list of Copilot Posting contests available to current user.
  - Since: TC Direct - Manage Copilot Postings assembly
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>

<c:set var="PAGE_TYPE" value="copilot" scope="request"/>
<c:set var="CURRENT_TAB" value="copilotPostings" scope="request"/>
<c:set var="CURRENT_SUB_TAB" value="copilotContestDetails" scope="request"/>

<c:set var="contestDTO" value="${viewData.contestStats.contest}"/>
<c:set var="contest" value="${result}"/>
<c:set var="projectHeader" value="${contest.projectHeader}"/>
<c:set var="assetDTO" value="${contest.assetDTO}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="includes/htmlhead.jsp"/>
    <link rel="stylesheet" href="/css/dashboard-view.css" media="all" type="text/css"/>
    <script type="text/javascript" src="/scripts/dashboard-view.js"></script>
    <script type="text/javascript" src="/scripts/copilots.js"></script>
    <script type="text/javascript" src="/scripts/jquery.tools.min.js"></script> 
    <script type="text/javascript">
        $(document).ready(function() {
            $('#projects2').getSetSSValue('${projectHeader.tcDirectProjectId}');
            $('#billingProjects2').getSetSSValue('${projectHeader.properties["Billing Project"]}');
            projectId = ${projectHeader.id};
            $('#mainContent').data('p1', '${projectHeader.tcDirectProjectId}');
            $('#mainContent').data('p2', '${projectHeader.properties["Billing Project"]}');
            $('#mainContent').data('p3', '${assetDTO.productionDate}');
            var d;
        <c:forEach items="${assetDTO.documentation}" var="doc" varStatus="loop">
            d = {};
            d['fileName'] = '${doc.documentName}';
            d['documentId'] = ${doc.id};
            d['description'] = '';
            documents.push(d);
            documents2.push(d);
        </c:forEach>
        <c:forEach items="${assetDTO.compUploadedFiles}" var="doc" varStatus="loop">
            <!-- ${doc.uploadedFileName} ${doc.uploadedFileDesc} -->
        </c:forEach>
        });
    </script>
</head>

<body id="page">
<div id="wrapper">
<div id="wrapperInner">
<div id="container">
<div id="content">

<jsp:include page="includes/header.jsp"/>

<div id="mainContent" style="overflow:visible">

<jsp:include page="includes/right.jsp"/>

<div id="area1"><!-- the main area -->
<div class="area1Content">

<div class="currentPage">
    <a href="${ctx}/dashboard" class="home">Dashboard</a> &gt;
    <a href="<s:url action='launchCopilotContest' namespace='/copilot'/>">Copilots</a> &gt;
    <strong>My Copilot Selection Contests</strong>
</div>
<!-- End .currentPage -->

<div id="copilotsIntroduction">
<div class="orderReview">

<div class="myCopilotsContests">
   <span class="introductionHeadIcon"><img src="/images/copilot_contests_icon.png" alt="copilot contests"/></span>

    <h2 class="sectionHead"><c:out value="${viewData.contestStats.contest.title}"/></h2>
</div>
<!-- end .getCopilots -->

<div class="myCopilotsContestsList">

<jsp:include page="includes/copilot/contestStats.jsp"/>

<div class="container2 tabs3Container tabs3Special">

<jsp:include page="includes/copilot/tabs.jsp"/>
<div class="container2Left">
<div class="container2Right">
<div class="container2BottomClear">

<div id="launchContestOut" class="launchCopilotContest">

<!-- add new contest -->
<div class="editMask">
    <div class="addNewContestInfo infoPanel ">
        <h3><span class="icon">General Information</span>
            <if:isDraft typedContestBrief="${contestDTO}">
                <a href="javascript:" class="editLink">
                    <img class="edit_type" alt="edit" src="/images/edit.png"/> </a>
            </if:isDraft>
        </h3>

        <div class="infoPanelMask">
            <ul>
                <li><label>Contest Name :</label>
                    <strong id="contestNameTextLabel"><c:out value="${assetDTO.name}"/></strong>
                </li>
                <li>
                    <label>Project Name :</label>
                    <strong id="projectNameTextLabel">
                        <c:forEach items="${projects}" var="p">
                            <c:if test="${p.projectId eq projectHeader.tcDirectProjectId}">
                                <c:out value="${p.name}"/>
                            </c:if>
                        </c:forEach>
                    </strong>
                </li>
                <li>
                    <label>Billing Account :</label>
                    <strong id="billingProjectNameTextLabel">
                        <c:forEach items="${billingProjects}" var="p">
                            <c:if test="${p.projectId eq projectHeader.properties['Billing Project']}">
                                <c:out value="${p.name}"/>
                            </c:if>
                        </c:forEach>
                    </strong>    
                </li>
            </ul>
        </div>
    </div>
    <div class="addNewContest editPanel">
        <h3>
            <span class="icon">General Information</span>
            <a href="javascript:" class="editLink"> <img class="edit_type" alt="edit" src="/images/edit.png"/></a>
        </h3>

        <div class="editPanelMask">
            <!-- Project Name -->
            <div class="row">
                <label for="projects2">Select the project that needs a Copilot :</label>
                <div class="projectSelect">
                    <select id="projects2">
                        <option value="-1">Please select an existing project</option>
                        <c:forEach items="${projects}" var="p">
                            <option value="${p.projectId}"
                                <c:if test="${p.projectId eq projectHeader.tcDirectProjectId}">selected="selected"</c:if>>
                                <c:out value="${p.name}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="addNew">
                    <a href="javascript:" class="button6" id="addNewProject2">
                        <span class="left"><span class="right">ADD NEW</span></span></a>
                </div>
            </div>

            <!-- Contest Name -->
            <div class="row">
                <label for="contestNameInput2">Create a name for your Copilot Posting :</label>
                <input type="text" class="text" id="contestNameInput2" value="${assetDTO.name}"/>
            </div>

            <!-- Billing Account -->
            <div class="row">
                <label for="billingProjects2">Select Your Billing Account :</label>
                <div class="billingSelect">
                    <select id="billingProjects2">
                        <option value="0">Please select an existing account</option>
                        <c:forEach items="${billingProjects}" var="p">
                            <option value="${p.projectId}"
                                <c:if test="${p.projectId eq projectHeader.properties['Billing Project']}">selected="selected"</c:if>>
                                <c:out value="${p.name}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <p class="save">
                <a class="cancel_text" href="javascript:" id="cancelContestInfo">cancel</a>
                <a href="javascript:" id="saveContestInfo">
                    <img class="save_btn" alt="save" src="/images/save_change.png"/></a>
            </p>
        </div>
    </div>
</div>
<!-- end .addNewContest -->


<!-- Contest Schedule -->
<div class="editMask greybg">
    <div class="infoPanel scheduleInfo ">
        <h3>
            <span class="icon">Contest Schedule</span>
            <if:isDraft typedContestBrief="${contestDTO}">
                <a href="javascript:" class="editLink">
                    <img class="edit_type" alt="edit" src="/images/edit.png"/> </a>
            </if:isDraft>
        </h3>

        <div class="infoPanelMask">
            <ul>
                <li>
                    <label>Start Time:</label> 
                    <span id="startDateLabel"><fmt:formatDate value="${tcdirect:toDate(assetDTO.productionDate)}" 
                                                              pattern="MM/dd/yyyy HH:mm zzz"/></span>
                </li>
<%--
                <li>
                    <label>End Time:</label> <span id="endDateLabel">08/22/2010 8:00 EST</span>
                </li>
--%>
            </ul>
        </div>
    </div>
    <div class="schedule editPanel">
        <h3>
            <span class="icon">Contest Schedule</span>
            <a href="javascript:"><img class="edit_type" alt="edit" src="/images/edit_red.png"/></a>
        </h3>

        <div class="editPanelMask">
        <!-- Start -->
            <div class="row">
                <label for="start2DateInput">Start:</label>
                <s:textfield cssClass="text date-pick" id="start2DateInput" readonly="true"/>

                <div class="startEtSelect">
                    <select id="start2TimeInput">
                        <jsp:include page="/WEB-INF/includes/common/timeOptions.jsp"/>
                    </select>
                </div>
                <span>ET (GMT-04)</span>
            </div>

            <p class="save">
                <a class="cancel_text" href="javascript:" id="cancelDates">cancel</a>
                <a href="javascript:" id="saveDates">
                    <img class="save_btn" alt="save" src="/images/save_change.png"/></a>
            </p>
        </div>
    </div>
</div>
<!-- end .schedule -->

<!-- Contest Description -->

<div class="editMask">
    <div class="infoPanel descriptionInfo ">
        <h3>
            <span class="icon">Description that you want everyone to see</span>
            <if:isDraft typedContestBrief="${contestDTO}">
                <a href="javascript:" class="editLink">
                    <img class="edit_type" alt="edit" src="/images/edit.png"/> </a>
            </if:isDraft>
        </h3>

        <div class="infoPanelMask">
            <div id="publicDescriptionText">${projectHeader.projectSpec.detailedRequirements}</div>
        </div>
    </div>
    <div class="description editPanel">
        <h3>
            <span class="icon">Enter a description that you want everyone to see</span>
            <a href="javascript:"><img class="edit_type" alt="edit" src="/images/edit_red.png"/></a>
        </h3>

        <div class="editPanelMask">
            <div class="textarea">
                <textarea rows="15" cols="80" style="width:100%;" 
                          id="publicCopilotPostingDescription2">${projectHeader.projectSpec.detailedRequirements}</textarea>
            </div>

            <p class="save">
                <a class="cancel_text" href="javascript:" id="cancelPublicDesc">cancel</a>
                <a href="javascript:" id="savePublicDesc">
                    <img class="save_btn" alt="save" src="/images/save_change.png"/></a>
            </p>
        </div>
    </div>
</div>
<!-- end .description -->

<div class="editMask greybg">
    <div class="infoPanel descriptionInfo ">
        <h3>
            <span class="icon">Description that is only viewable to copilots that register for this posting</span>
            <if:isDraft typedContestBrief="${contestDTO}">
                <a href="javascript:" class="editLink">
                    <img class="edit_type" alt="edit" src="/images/edit.png"/> </a>
            </if:isDraft>
        </h3>

        <div class="infoPanelMask">
            <div id="privateDescriptionText">${projectHeader.projectSpec.privateDescription}</div>
        </div>
    </div>
    <div class="description editPanel">
        <h3>
            <span class="icon">Enter a description that is only viewable to copilots that register for this posting</span>
            <a href="javascript:"><img class="edit_type" alt="edit" src="/images/edit_red.png"/></a></h3>

        <div class="editPanelMask">
            <div class="textarea">
                <textarea rows="15" cols="80" style="width:100%;" 
                          id="privateCopilotPostingDescription2">${projectHeader.projectSpec.privateDescription}</textarea>
            </div>

            <p class="save">
                <a class="cancel_text" href="javascript:" id="cancelPrivateDesc">cancel</a>
                <a href="javascript:" id="savePrivateDesc">
                    <img class="save_btn" alt="save" src="/images/save_change.png"/></a>
            </p>
        </div>
    </div>
</div>
<!-- end .description -->


<!-- fileUpload -->
<div class="editMask">
    <div class="infoPanel fileUploadInfo ">
        <h3>
            <span class="icon">Files</span>
            <if:isDraft typedContestBrief="${contestDTO}">
                <a href="javascript:" class="editLink">
                    <img class="edit_type" alt="edit" src="/images/edit.png"/> </a>
            </if:isDraft>
        </h3>

        <div class="infoPanelMask">
        <table id="uploadedDocumentsTable">
            <c:forEach items="${assetDTO.compUploadedFiles}" var="doc" varStatus="loop">
                <tr>
                    <td class="fileName"><span>${loop.index + 1}.</span>
                        <a href="#"><c:out value="${doc.fileName}"/></a></td>
                    <td class="fileDesc"><c:out value="${doc.description}"/></td>
                </tr>
            </c:forEach>
            </table>
        </div>
    </div>
    <div class="fileUpload editPanel">
        <h3>
            <span class="icon">Files</span>
            <a href="javascript:"><img class="edit_type" alt="edit" src="/images/edit_red.png"/></a>
        </h3>

        <div class="editPanelMask">
            <dl>
                <dd class="addFile">
                    <div class="attachFile" id="attachFileDiv2">
                        <input type="file" class="fileInput" name="document"/>
                        <table>
                            <tbody>
                            <tr>
                                <td class="fakeText"><input type="text" id="fakeTextInput2"/></td>
                                <td class="uploadBtn"><a href="javascript:" class="button6">
                                    <span class="left"><span class="right">CHOOSE...</span></span></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="attachDesc">
                        <table>
                            <tbody>
                            <tr>
                                <td class="descInput"><input type="text" id="fileDescription2"/></td>
                                <td class="addDelBtn">
                                    <a class="addButton" id="fileUploadBtn2" href="javascript:"><span class="hide">ADD</span></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </dd>
            </dl>
            <p class="save">
                <a class="cancel_text" href="javascript:" id="cancelFiles">cancel</a>
                <a href="javascript:" id="saveFiles">
                    <img class="save_btn" alt="save" src="/images/save_change.png"/></a>
            </p></div>
    </div>
</div>
<!-- end .fileUpload -->


</div>
<!-- end #launchContestOut -->

</div>
</div>
</div>

</div>
</div>
<!-- end .getCopilotsStep -->


</div>
<!-- end .orderReview -->


</div>
<!-- end #copilotsIntroduction -->

<!-- end #launchContestOut -->
</div>
<!-- End.area1Content -->
</div>
<!-- End #area1 -->

</div>
<!-- End #mainContent -->

<jsp:include page="includes/footer.jsp"/>

</div>
<!-- End #content -->
</div>
<!-- End #container -->
</div>
</div>
<!-- End #wrapper -->
<!-- this area will contain the popups of this page -->
<div id="saveAsDraft" class="acceptRejectPopup hide">
    <div class="popupMask">
        <div class="popupWrap">
            <div class="popupContent">
                <dl>
                    <dt>Your Copilot Selection Contest has been saved as draft</dt>
                         
                    <dd class="yesno">
                         <a href="#" class="button6" id="saveAsDraftOK"><span class="left"><span class="right">OK</span></span></a>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
</div>
<div class="popups">
    <!-- Add Project Dialog-->
    <div id="addProjectDialog" title="Create New Project" class="dialog-box hide">
        <div id="addProjectForm">
            <div class="fi">
                <label for="projectName">Name:</label>
                <input id="projectName" name="projectName" type="text" width="30" maxlength="255"/>
            </div>
            <div class="fi">
                <label for="projectDescription">Description:</label>
                <textarea id="projectDescription" name="projectDescription" rows="5" cols="30"></textarea>
            </div>
            <div class="popupButtons">
                <a href="javascript:" onclick="closeDialog(this);" class="button1"><span>Cancel</span></a>
                <a href="javascript:" onclick="addNewProject();" class="button1"><span>Yes</span></a>
            </div>
        </div>
        <!-- End #addProjectForm -->

        <div id="addProjectResult">
            <p></p>

            <div class="popupButtons">
                <a href="javascript:" onclick="closeDialog(this);" class="button1"><span>Close</span></a>
            </div>
        </div>
        <!-- End #addProjectResult -->
    </div>
    <!-- End #addProjectDialog -->
</div>
<div id="uploadedDocumentTemplate" class="hide">
    <dd id="doc{0}" class="uploadedDocumentItem">
        <div class="attachFile">{1}</div>
        <div class="attachDesc">
            <table>
                <tbody>
                <tr>
                    <td class="descInput">{2}</td>
                    <td class="addDelBtn">
                        <a class="removeButton" href="javascript:removeFileItem('{0}', documents2);" id="removeButton{0}">
                            <span class="hide">REMOVE</span></a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </dd>
</div>

<!-- End .popups -->
<jsp:include page="includes/popups.jsp"/>
</body>
<!-- End #page -->
</html>