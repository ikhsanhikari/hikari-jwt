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
        <link href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/styles/github.min.css' rel="stylesheet"/>
        <script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/highlight.min.js'></script>
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

                                <div class="widget widget-table action-table">
                                    <div class="widget-header"> <i class="icon-th-list"></i>
                                        <h3>List Pattern</h3>
                                    </div>
                                    <!-- /widget-header -->
                                    <div class="widget-content">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th> No </th>
                                                    <th> Pattern Code</th>
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
                                <!-- /widget -->
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
            <!-- /main-inner --> 
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

        <script>
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
                                                        var desc = item.id + `,` + item.courseLevel + `,` + item.courseType;
                                                        content += `<tr>
                                                    <td> ` + (index + 1) + ` </td>
                                                    <td> ` + item.id + ` </td>
                                                    <td> ` + item.courseType + ` </td>
                                                    <td> ` + item.courseLevel + ` </td>
                                                    <td class="td-actions">
                                                        <a href="#patternModal` + index + `" data-toggle="modal" class="btn btn-default btn-small"><i class="btn-icon-only icon-eye-open"> </i></a>
                                                    </td>
                                                </tr>`;


                                                        modal += `<div id="patternModal` + index + `" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="patternModalLabel" aria-hidden="true">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h3 id="patternModalLabel">PATTERN` + desc + `</h3>
                                        </div>
                                        <div class="modal-body">
                                            <pre><code class='java'>` + item.pattern + `</code></pre>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                        </div>
                                    </div>`;
                                                    })
                                                    $('#listPatternTable').html(content);
                                                    $('#listModal').html(modal);
                                                    hljs.initHighlighting.called = false;
                                                    hljs.initHighlighting();
                                                }
                                            });
                                        }
                                        function reset() {
                                            $('#courseType').val('');
                                            $('#courseLevel').val('');
                                            listPattern();
                                        }

        </script>
    </body>
</html>
