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
                                <div class="widget-header"> <i class="icon-bookmark"></i>
                                    <h3>Important Shortcuts</h3>
                                </div>
                                <!-- /widget-header -->
                                <div class="widget-content">
                                    <div class="shortcuts"> 
                                        <a href="create-pattern" class="shortcut">
                                            <i class="shortcut-icon icon-plus"></i>
                                            <span class="shortcut-label">Create Pattern</span> 
                                        </a>
                                        <a href="list-pattern" class="shortcut">
                                            <i class="shortcut-icon icon-list"></i>
                                            <span class="shortcut-label">List Pattern</span> 
                                        </a>
                                    </div>
                                    <!-- /shortcuts --> 
                                </div>
                                <!-- /widget-content --> 
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


    </body>
</html>
