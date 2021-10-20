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
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    <link href="resources/css/font-awesome.css" rel="stylesheet">
    <link href="resources/css/style.css" rel="stylesheet">
    <link href="resources/css/pages/dashboard.css" rel="stylesheet">
</head>

<body>
    <jsp:include page="common/navbar.jsp" />
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row">
                    <div class="span7">
                        <div class="widget">
                            <div class="widget-header"> <i class="icon-code"></i>
                                <h3>Live Code</h3>
                            </div>
                            <div class="widget-content">
                                <div class="row">
                                    <div class="span2">
                                        <div class="control-group">
                                            <label class="control-label" for="course">Course Type</label>
                                            <div class="controls">
                                                <select class="span2" id="courseType">
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
                                                    <option value="LOW">Low</option>
                                                    <option value="MEDIUM">Medium</option>
                                                    <option value="HIGH">High</option>
                                                    </select>
                                            </div>
                                        </div>
                                    </div>
<!--                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="desc">Description</label>
                                            <div class="controls">
                                                <textarea class="span6" style="height: 50px" id="desc"></textarea>
                                            </div>
                                        </div>
                                    </div>-->
                                </div>
                                <div class="row">
                                    <div class="span6">
                                        <div class="control-group">
                                            <!--<label class="control-label" for="code">Pattern</label>-->
                                            <div class="controls">
                                                <textarea class="span6" style="height: 200px" id="code"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">

                                    </div>
                                </div>
                                <button type="submit" onclick="compile()" id="btnSave" class="btn btn-primary">Save</button>
                                <button class="btn btn-danger" onclick="defaultCode()">Default Code</button>
                            </div>
                        </div>
                    </div>
                    <div class="span5">
                        <div class="widget">
                            <div class="widget-header"> <i class="icon-code"></i>
                                <h3>Output</h3>
                            </div>
                            <div class="widget-content">
                                <div style="height: 325px" id="output"></div>
                            </div>
                        </div>
                    </div>

                    <!-- /span6 -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /main-inner -->
    </div>
    <jsp:include page="common/footer.jsp" />
            ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="resources/js/jquery-1.7.2.min.js"></script>
    <script src="resources/js/excanvas.min.js"></script>
    <script src="resources/js/chart.min.js" type="text/javascript"></script>
    <script src="resources/js/bootstrap.js"></script>
    <script language="javascript" type="text/javascript" src="resources/js/full-calendar/fullcalendar.min.js"></script>

    <script src="resources/js/base.js"></script>
    <script src="resources/js/sweetalert2.js"></script> 


</body>
<script type="text/javascript">
    var base_url = '/hikari-jwt/';
    
    function defaultCode() {
        document.getElementById('code').value = `class Program {
            public static void main(String[]args){
                System.out.println("Hikari Learning");
            }
        }`;

    }

    function compile() {
        req = {};
        req.code = $('#code').val();
        req.output = ''
        $('#btnSave').html('Save...');
        $.ajax({
            url: 'write-java',
            type: 'POST',
            data: JSON.stringify(req),
            headers: {
                'Content-type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            success: function(data) {
                if(data.status == 'Success'){
                    Swal.fire({
                        title: 'Your pattern is correct, Will you save this pattern ?',
                        showDenyButton: true,
                        showCancelButton: true,
                        confirmButtonText: 'Save',
                        denyButtonText: `Don't save`,
                      }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                          savePattern();
                          Swal.fire('Saved!', '', 'success')
                        } else if (result.isDenied) {
                          Swal.fire('Changes are not saved', '', 'info')
                        }
                      })
                }
                $('#btnSave').html('Save');
                $('#output').html(data.data.output)
            }
        })
    }
    
    function savePattern() {
        req = {};
        req.pattern = $('#code').val();
        req.courseLevel = $('#courseLevel').val();
        req.courseType = $('#courseType').val();
        
        $.ajax({
            url: 'pattern/save',
            type: 'POST',
            data: JSON.stringify(req),
            headers: {
                'Content-type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            success: function(data) {
                $('#output').html(data.data.output)
            }
        })
    }
</script>

<style>
    #code {
        font-size: 13px;
        font-family: 'Monalisa Font', sans-serif;
    }
    
    #output {
        font-size: 13px;
        font-family: 'Monalisa Font', sans-serif;
        /* white-space: initial; */
        word-wrap: break-word;
    }
</style>

</html>