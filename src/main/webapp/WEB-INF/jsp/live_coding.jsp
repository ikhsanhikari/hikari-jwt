<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Hikari Learning</title>
    <link rel="icon" type="image/png" href="resources/img/favicon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
    <link href="resources/css/font-awesome.css" rel="stylesheet">
    <link href="resources/css/style.css" rel="stylesheet">
    <link href="resources/css/pages/dashboard.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/codemirror.min.css" rel="stylesheet" />
    <link href="resources/css/eclipse.css"
        rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.58.3/mode/clike/clike.min.js"></script>
    <link href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/styles/github.min.css' rel="stylesheet" />
    <script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/highlight.min.js'></script>
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
                                <button type="submit" onclick="compile()" id="btnSave"
                                    class="btn btn-primary">Compile</button>
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
                                <div id="output"></div>
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

    var editor = CodeMirror.fromTextArea(document.getElementById('code'), {
        mode: "text/x-java",
        indentWithTabs: true,
        smartIndent: true,
        lineNumbers: true,
        lineWrapping: true,
        matchBrackets: true,
        autofocus: true,
        theme: "eclipse",
    });

    function defaultCode() {
        editor.getDoc().setValue(`class Program {
    public static void main(String[]args){
        System.out.println("Hikari Learning");
    }
}`);

    }

    function compile() {
        req = {};
        req.code = editor.getDoc().getValue();
        req.output = ''
        loadingButton('btnSave', true);
        $.ajax({
            url: 'write-java',
            type: 'POST',
            data: JSON.stringify(req),
            headers: {
                'Content-type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            success: function (data) {
                if (data.status == 'Success') {
                    
                }else{
                      Swal.fire(data.data.output, '', 'error')
                }
                loadingButton('btnSave', false);
                cont =  data.data.output ;
                cont =cont.replace(new RegExp('\r?\n','g'), "<br/>");
                console.log(cont)
                $('#output').html(cont);
                hljs.initHighlighting.called = false;
                hljs.initHighlighting();
            },
            error: function(data) {
                loadingButton('btnSave', false);
            }
        })
    }

    function loadingButton(id, isActive) {
        if (isActive) {
            $('#' + id).addClass('loading');
        } else {
            $('#' + id).removeClass('loading');
        }

        $('#' + id).attr('disabled', isActive);
    }


</script>

<style>
    #output {
        font-size: 13px;
        font-family: 'Monalisa Font', sans-serif;
        /* white-space: initial; */
        word-wrap: break-word;
    }

    .loading:after {
        overflow: hidden;
        display: inline-block;
        vertical-align: bottom;
        -webkit-animation: ellipsis steps(4, end) 900ms infinite;
        animation: ellipsis steps(4, end) 900ms infinite;
        content: "\2026";
        /* ascii code for the ellipsis character */
        width: 0px;
    }

    @keyframes ellipsis {
        to {
            width: 20px;
        }
    }

    @-webkit-keyframes ellipsis {
        to {
            width: 20px;
        }
    }
</style>

</html>