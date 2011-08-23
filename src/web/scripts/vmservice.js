/*
 * Copyright (C) 2011 TopCoder Inc., All Rights Reserved.
 */
/**
 * The JS script for VM service.
 *
 *  Version 1.1 - TC Direct UI Improvement Assembly 1 (BHCUI-90) Change Note
 *  - Solve "all clear buttons in "VM Management" cannot work"
 *
 * @author winsty
 * @version 1.1 (TC Direct UI Improvement Assembly 1)
 */
var vmTable;
var columnCount;

$(document).ready(function() {
    columnCount = $("#contest_vms").find('tr')[0].cells.length;

    if (columnCount == 12) {
        vmTable = $("#contest_vms").dataTable({
            "bPaginate": false,
            "bFilter": false,
            "bSort": true,
            "bAutoWidth": false,
            "bInfo": false,
            "aaSorting": [[4,'asc']],
            "aoColumns": [
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    { "sType": "date-direct" },
                    null,
                    { "sClass": "vm_instance_status" },
                    { "sClass": "vm_instance_action" }
                ]
        });
    } else {
        vmTable = $("#contest_vms").dataTable({
            "bPaginate": false,
            "bFilter": false,
            "bSort": true,
            "bAutoWidth": false,
            "bInfo": false,
            "aaSorting": [[4,'asc']],
            "aoColumns": [
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    { "sType": "date-direct" },
                    null,
                    { "sClass": "vm_instance_status" },
                    { "sClass": "vm_instance_action" }
                ]
        });
    }
});

function addData(vm) {
    var action = '';
    if (vm.status == 'RUNNING') {
       	action = '<a href="javascript:void(0)" onclick="javascript:vmService.terminate(' + vm.instance.id + ', this);" class="button6" style="margin:auto;"><span class="left"><span class="right">Terminate</span></span></a>';
    }

    if (columnCount == 12) {
        vmTable.fnAddData([
            vm.instance.contestId,
            vm.contestName,
            vm.vmImageTcName,
            vm.accountName,
            vm.instance.svnBranch,
            vm.instance.tcMemberHandle,
            vm.managerHandle,
            vm.instance.publicIP,
            vm.vmCreationTime,
            vm.usage,
            vm.status,
            action
        ]);
    } else {
        vmTable.fnAddData([
            vm.instance.contestId,
            vm.contestName,
            vm.vmImageTcName,
            vm.accountName,
            vm.instance.svnBranch,
            vm.instance.tcMemberHandle,
            vm.instance.publicIP,
            vm.vmCreationTime,
            vm.usage,
            vm.status,
            action
        ]);
    }
}

if (!window.vmService) var vmService = {
    launch : function(formId) {
        var data = $('#' + formId).serialize();
        $(".error").empty();
        var actionArea = $('#launch_vm_button');
        var save = actionArea.html();
        actionArea.html('');

        modalPreloader();

        $.ajax({
            type: 'GET',
            url:'launchVMInstance',
            data: data,
            dataType: "json",
            cache:false,
            success:function(r) {
                modalClose();
                actionArea.html(save);
                r = r.result['return'];
                var errors = r.errors;
                if (errors) {
                    for (var p=0; p<errors.length; p++) {
                        //Judge whether it is IE
                        var ua = navigator.userAgent.toLowerCase(); 
                        if (window.ActiveXObject && ua.match(/msie ([\d.]+)/)[1] < 8.0){
                            $('#' + errors[p].propertyName + 'Error').html(errors[p].messages[0]).show();
                        } else {
                            $('#' + errors[p].propertyName + 'Error').html(errors[p].messages[0]).css('display', 'inline-block');
                        }
                    }
                } else {
					var container = $('.vm_instances_body');
					for (var i=0; i<r.length; i++) { // is able to launch multiple VMs at once
                        addData(r[i]);
                    }


                }
            }
        });
    },

    refresh : function() {
        $(".error").empty();
        modalPreloader();

        $.ajax({
            type: 'GET',
            url:'showVMInstances',
            dataType: "json",
            cache:false,
            success:function(r) {
                modalClose();
                r = r.result['return'];
                var errors = r.errors;
                if (errors) {
                    $('#generalError').html("failed to load vm data");
                } else {
                    vmTable.fnClearTable();
                    for (var i=0; i<r.length; i++) {
                        addData(r[i]);
                    }
                }
            }
        });
    },


    terminate : function(instanceId, elem) {                         
        if (window.confirm("Are you sure you want to terminate this VM?")) {
            modalPreloader();
            while (elem.parentNode && elem.parentNode.tagName != "TR"){
                elem = elem.parentNode;
            }
            var rowElem = elem.parentNode;
            var actionArea = $(rowElem).find(".vm_instance_action");
            actionArea.html('');
            $.ajax({
                type: 'POST',
                url: 'terminateVMInstance',
                data: {'instanceId' : instanceId},
                dataType: "json",
                cache: false,
                success: function(r) {
                    modalClose();
                    $(rowElem).find('.vm_instance_status').html(r.result['return'][0]);                                       
                }
            });
        }        
    }
}
$(function(){
    /*
        *  BHCUI-90
        *  Click action for launchVM.
        */
    $('#launchVM').click(function(){
        $(".error").hide();
        vmService.launch('vm-launch-form');
    });
});
