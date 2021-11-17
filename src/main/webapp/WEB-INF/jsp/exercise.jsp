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
                    <div class="globalMessage" style="visibility: hidden">
                        <div class="alert">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>Warning!</strong> <p id="reqMessage"></p> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="span12">
                            <div class="widget">
                                <div class="widget-header"> <i class="icon-bookmark"></i>
                                    <h3>Exercise</h3>
                                </div>
                                <div class="widget-content">
                                    <button class="btn btn-primary" id="generateExercise" onclick="generateQuestion()">Generate Exercise</button>

                                    <div class="shortcuts"> 
                                        <a href="#" id="btnExercise" class="shortcut ">
                                            <i class="shortcut-icon icon-terminal"></i>
                                            <span class="shortcut-label">Start Exercise</span> 
                                        </a>
                                    </div>
                                </div>
                            </div> 
                        </div>

                        <div class="span12" id="exerciseWrap">
                            <div class="widget">
                                <div class="widget-header"> <i class="icon-bookmark"></i>
                                    <h3>Question</h3>
                                </div>
                                <div class="widget-content">
                                    <div  id="questionWrap">
                                    </div>
                                    <hr>
                                    <div class="span10">&nbsp;</div>
                                    <button class="btn btn-primary" onclick="cekAnswer()"  data-toggle="modal">Submit</button>
                                </div>
                            </div> 
                        </div> 
                    </div>
                </div>
            </div>
        </div>
        <div id="answerModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="answerModalLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h3 id="answerModalLabel" >Result</h3>
            </div>
            <div class="modal-body">
                <div>
                    <div class="widget-content">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th> No </th>
                                    <th> Status</th>
                                    <th> Right Answer</th>
                                </tr>
                            </thead>
                            <tbody id="lastResult">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
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
                                        var generateId = '';
                                        var idQuestion = [];
                                        $('#exerciseWrap').hide();
                                        $('#btnExercise').click(function () {
                                            preview();

                                        })

                                        function preview() {
                                            if (generateId.length < 1) {
                                                Toast.fire({
                                                    icon: 'error',
                                                    title: 'Please Generate Question First !'
                                                })
                                            } else {
                                                $.ajax({
                                                    url: 'bank/findByGenerateId?generateId=' + generateId,
                                                    type: 'GET',
                                                    headers: {
                                                        'Content-type': 'application/json',
                                                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                    },
                                                    success: function (data) {
                                                        idLokal = [];
                                                        content = '';
                                                        data.data.forEach(function (item, index) {
                                                            content += '<b>' + (index + 1) + '.</b>';
                                                            content += '<pre><code class="java">' + item.pattern + '</code></pre><br/>';
                                                            content += `
                                        <div class="controls">
                                            <input class="span4" required id="answer` + item.id + `"  placeholder="Your Answer"/>
                                        </div></br>`;
                                                            idLokal.push(item.id);
                                                        })
                                                        idQuestion = idLokal;
                                                        $('#questionWrap').html(content);
                                                        $('#exerciseWrap').show();
                                                        hljs.initHighlighting.called = false;
                                                        hljs.initHighlighting();
                                                    },
                                                    error: function () {
                                                    }
                                                })
                                            }
                                        }


                                        function cekAnswer() {
                                            var reqAnswerAll = []
                                            idQuestion.forEach(function (item, index) {
                                                var reqAnswer = {
                                                    generateId: generateId,
                                                    answer: $('#answer' + item).val(),
                                                    id: item
                                                };

                                            })
                                            $.ajax({
                                                url: 'bank/answer',
                                                type: 'POST',
                                                data: JSON.stringify(reqAnswerAll),
                                                headers: {
                                                    'Content-type': 'application/json',
                                                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                },
                                                success: function (data) {
                                                    content = '';
                                                    data.data.forEach(function (item, index) {
                                                        content += `<tr>
                                                    <td>` + (index + 1) + `</td>
                                                    <td>` + item.result + `</td>
                                                    <td>` + item.rightAnswer + `</td>
                                                </tr>`;
                                                    })
                                                    var valid = addValidation(idQuestion);
                                                    console.log(replaceAll(valid.toString(),',','</br>'));
                                                    if (valid.length >= 0) {
                                                        $('#reqMessage').html(replaceAll(valid.toString(),',','</br>'));
                                                        $('.globalMessage').css('visibility', 'visible');
                                                        window.scrollTo(0, 0);
                                                    } else {
                                                        $('#lastResult').html(content);
                                                        $('#answerModal').modal('show');
                                                    }

                                                },
                                                error: function () {
                                                }
                                            })

                                        }
                                        function replaceAll(str, find, replace) {
                                            return str.replace(new RegExp(find, 'g'), replace);
                                        }
                                        function loadingButton(id, isActive) {
                                            if (isActive) {
                                                $('#' + id).addClass('loading');
                                            } else {
                                                $('#' + id).removeClass('loading');
                                            }
                                            $('#' + id).attr('disabled', isActive);
                                        }
                                        function generateQuestion() {
                                            $('#exerciseWrap').hide();
                                            loadingButton('generateExercise', true);
                                            req = {
                                                id: [1, 2]
                                            }
                                            if (req.id.length > 0) {
                                                $.ajax({
                                                    url: 'pattern/findAllByIdForExercise',
                                                    type: 'POST',
                                                    data: JSON.stringify(req),
                                                    headers: {
                                                        'Content-type': 'application/json',
                                                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                                                    },
                                                    success: function (data) {
                                                        generateId = data.data;
                                                        loadingButton('generateExercise', false);
                                                        Toast.fire({
                                                            icon: 'success',
                                                            title: 'Good! Question generated successfully!'
                                                        })
                                                    },
                                                    error: function () {
                                                        loadingButton('generateExercise', false);
                                                    }
                                                })
                                            } else {
                                                loadingButton('generateExercise', false);
                                                Toast.fire({
                                                    icon: 'error',
                                                    title: 'Choose one pattern or more !'
                                                })
                                            }

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

                                        function addValidation(number) {
                                            var content = [];
                                            number.forEach(function (item, index) {
                                                if ($('#answer' + item).val().length <= 0) {
                                                    content.push(` Question Number ` + (index + 1) + ` is Required!`);
                                                }
                                            })

                                            return content;
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
            .loading:after {
                overflow: hidden;
                display: inline-block;
                vertical-align: bottom;
                -webkit-animation: ellipsis steps(4,end) 900ms infinite;      
                animation: ellipsis steps(4,end) 900ms infinite;
                content: "\2026"; /* ascii code for the ellipsis character */
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


    </body>
</html>
