<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Hikari Learning</title>
        <link rel="icon" type="image/png" href="resources/img/favicon.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/bootstrap-responsive.min.css" rel="stylesheet">
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
              rel="stylesheet">
        <link href="resources/css/font-awesome.css" rel="stylesheet">
        <link href="resources/css/style.css" rel="stylesheet">
        <link href="resources/css/pages/dashboard.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="common/navbar.jsp"/>
        <div class="main">
            <div class="main-inner">
                <div class="container">
                    <div class="row">
                        <div class="span12">
                            <div class="widget">
                                <div class="widget-header"> <i class="icon-search"></i>
                                    <h3>Search</h3>
                                </div>
                                <!-- /widget-header -->
                                <!-- /widget -->
                                <div class="widget-content">
                                    <div class="row">  
                                        <div class="span2">
                                            <div class="control-group">
                                                <label class="control-label" for="course">Course Type</label>
                                                <div class="controls">
                                                    <select class="span2" id="courseType">
                                                        <option value="">ALL</option>
                                                        <option value="SEQUENTIAL">Sequential</option>
                                                        <option value="CONDITIONAL">Conditional</option>
                                                        <option value="LOOPING">Looping</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span2">
                                            <div class="control-group">
                                                <label class="control-label" for="level">Level</label>
                                                <div class="controls">
                                                    <select class="span2" id="courseLevel">
                                                        <option value="">ALL</option>
                                                        <option value="LOW">Low</option>
                                                        <option value="MEDIUM">Medium</option>
                                                        <option value="HIGH">High</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary" onclick="listPattern()">Search</button>
                                    <button class="btn btn-danger" onclick="reset()" >Reset</button>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="span6">
                                        <div class="widget widget-table action-table ">
                                            <div class="widget-header"> <i class="icon-th-list"></i>
                                                <h3>List Pattern</h3>
                                            </div>
                                            <!-- /widget-header -->
                                            <div class="widget-content">
                                                <table class="table table-striped table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <th> No </th>
                                                            <th> Course Type</th>
                                                            <th> Course Level</th>
                                                            <th class="td-actions">Action </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="listPatternTable">

                                                    </tbody>
                                                </table>
                                            </div>
                                            <div id="listModal"></div>
                                            <!-- /widget-content --> 
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="widget ">
                                            <div class="widget-header"> <i class="icon-search"></i>
                                                <h3>Pattern that chosen</h3>
                                            </div>
                                            <div class="widget-content">
                                                <button type="button" class="btn btn-primary" onclick="generateQuestion()" id="generateQuestion">Generate</button>
                                                <button type="button" class="btn btn-danger" href="#previewModal" data-toggle="modal" onclick="preview()" id="btnPreview" style="visibility: hidden"  id="generateQuestion">Preview</button>
                                                <br/><br/>
                                                <div id="result">
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </div>


                                <!-- /widget -->
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
            <!-- /main-inner --> 
        </div>
        <!-- Modal -->
        <div id="previewModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="previewModalLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h3 id="previewModalLabel" ></h3>
            </div>
            <div class="modal-body">
                <div id="previewCode"></div>
                <h5>Answer</h5>
                <pre id="answerCode"></pre>
            </div>
            <div class="modal-footer">
                <button class="btn btn-info"  aria-hidden="true" onclick="download()">Download</button>
                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
        <!-- /main -->
        <jsp:include page="common/footer.jsp"/>
        <!-- Le javascript
        ================================================== --> 
        <!-- Placed at the end of the document so the pages load faster --> 
        <script src="resources/js/jquery-1.7.2.min.js"></script> 
        <script src="resources/js/excanvas.min.js"></script> 
        <script src="resources/js/chart.min.js" type="text/javascript"></script> 
        <script src="resources/js/bootstrap.js"></script>
        <script language="javascript" type="text/javascript" src="resources/js/full-calendar/fullcalendar.min.js"></script>

        <script src="resources/js/base.js"></script> 
        <script src="resources/js/sweetalert2.js"></script> 

        <script>

                                                    listPattern();
                                                    function listPattern() {
                                                        var level = $('#courseLevel').val();
                                                        var type = $('#courseType').val();
                                                        $.ajax({
                                                            url: 'pattern/findByCourse?level=' + level + '&type=' + type,
                                                            type: 'GET',
                                                            headers: {
                                                                'Content-type': 'application/json',
                                                                'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                            },
                                                            success: function (data) {
                                                                var listPattern = data.data;
                                                                var content = '';
                                                                var modal = '';
                                                                listPattern.forEach(function (item, index) {
                                                                    var desc = `Pattern` + item.id + `_` + item.courseLevel + `_` + item.courseType;
                                                                    content += `<tr>
                                                    <td> ` + (index + 1) + ` </td>
                                                    <td> ` + item.courseType + ` </td>
                                                    <td> ` + item.courseLevel + ` </td>
                                                    <td class="td-actions">
                                                        <a href="#patternModal` + index + `" data-toggle="modal" class="btn btn-default btn-small"><i class="btn-icon-only icon-eye-open"> </i></a>
                                                        
                                                            <input type="checkbox" value="` + item.pattern + `" name ="` + item.id + `" onchange="changeCheckBox()">
                                                        
                                                    </td>
                                                </tr>`;


                                                                    modal += `<div id="patternModal` + index + `" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="patternModalLabel" aria-hidden="true">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h3 id="patternModalLabel">` + desc + `</h3>
                                        </div>
                                        <div class="modal-body">
                                            <pre>` + item.pattern + `</pre>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                        </div>
                                    </div>`;
                                                                })
                                                                $('#listPatternTable').html(content);
                                                                $('#listModal').html(modal);
                                                            }
                                                        });
                                                    }
                                                    function reset() {
                                                        $('#courseType').val('');
                                                        $('#courseLevel').val('');
                                                        listPattern();
                                                    }
                                                    function addToList(obj) {
                                                        $(obj).removeClass('btn btn-default');
                                                        $(obj).addClass('btn btn-primary');
                                                    }
                                                    var sel = []
                                                    function changeCheckBox() {
                                                        var selected = [];
                                                        var pattern = [];
                                                        $('#listPatternTable input:checked').each(function () {
                                                            selected.push($(this).attr('name'));
                                                            pattern.push($(this).attr('value'));
                                                        });
                                                        var content = '';
                                                        pattern.forEach(function (item) {
                                                            content += '<pre>' + item + '</pre></br>';
                                                        })
                                                        sel = selected;
                                                        $('#result').html(content);
                                                    }
                                                    var generateId = '';
                                                    function generateQuestion() {
                                                        $('#generateQuestion').html('Generate...')
                                                        req = {
                                                            id: []
                                                        }
                                                        req.id = sel;
                                                        if (sel.length > 0) {
                                                            $.ajax({
                                                                url: 'pattern/findAllById',
                                                                type: 'POST',
                                                                data: JSON.stringify(req),
                                                                headers: {
                                                                    'Content-type': 'application/json',
                                                                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                                },
                                                                success: function (data) {
                                                                    generateId = data.data;
                                                                    $('#generateQuestion').html('Generate')
                                                                    $('#btnPreview').css('visibility', 'visible');
                                                                },
                                                                error: function () {
                                                                    $('#generateQuestion').html('Generate')
                                                                }
                                                            })
                                                        } else {
                                                            $('#generateQuestion').html('Generate')
                                                            Toast.fire({
                                                                icon: 'error',
                                                                title: 'Choose one pattern or more !'
                                                            })
                                                        }

                                                    }
                                                    function preview() {
                                                        $.ajax({
                                                            url: 'bank/findByGenerateId?generateId=' + generateId,
                                                            type: 'GET',
                                                            headers: {
                                                                'Content-type': 'application/json',
                                                                'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                            },
                                                            success: function (data) {
                                                                content = '';
                                                                answer = '';
                                                                data.data.forEach(function (item) {
                                                                    answer += '<b>' + item.id + ' : ' + item.answer + ' </b><br>';
                                                                    content += '<pre><b>' + (item.id) + '.</b></br>' + item.pattern + '</pre><br/>';
                                                                })
                                                                $('#answerCode').html(answer);
                                                                $('#previewCode').html(content);
                                                                $('#previewModalLabel').html('Generate ID:' + generateId);
                                                            },
                                                            error: function () {
//                                                                $('#generateQuestion').html('Generate');
                                                            }
                                                        })
                                                    }
                                                    const Toast = Swal.mixin({
                                                        toast: true,
                                                        position: 'top-end',
                                                        showConfirmButton: false,
                                                        timer: 3000,
                                                        timerProgressBar: true,
                                                        didOpen: (toast) => {
                                                            toast.addEventListener('mouseenter', Swal.stopTimer)
                                                            toast.addEventListener('mouseleave', Swal.resumeTimer)
                                                        }
                                                    })

                                                    function download() {
                                                        $.ajax({
                                                            url: 'pdf?output=' + generateId+'.pdf&generateId='+generateId,
                                                            type: 'GET',
                                                            headers: {
                                                                'Content-type': 'application/json',
                                                                'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                            },
                                                            success: function (data) {
                                                                alert('berhasil');
                                                            },
                                                            error: function () {
                                                            }
                                                        })
                                                    }

        </script>
        <style>
            pre {
                box-sizing: border-box;
                width: 100%;
                padding: 0;
                margin: 0;
                overflow: auto;
                overflow-y: hidden;
                font-size: 12px;
                line-height: 20px;
                background: #efefef;
                border: 1px solid #777;
                background: url(lines.png) repeat 0 0;
                padding: 10px;
                color: #333;
            }

        </style>
    </body>
</html>
