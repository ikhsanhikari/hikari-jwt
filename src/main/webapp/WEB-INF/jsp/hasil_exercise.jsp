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
</head>

<body>
    <jsp:include page="common/navbar.jsp" />
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <div class="widget">


                            <div class="widget widget-table action-table">
                                <div class="widget-header"> <i class="icon-star"></i>
                                    <h3>Hasil Exercise</h3>
                                </div>
                                <!-- /widget-header -->
                                <div class="widget-content">
                                    <table class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th> No </th>
                                                <th> Kode Soal</th>
                                                <th> Nama Latihan</th>
                                                <th> Result </th>
                                                <th> Jumlah Soal </th>
                                                <th> Detail </th>
                                            </tr>
                                        </thead>
                                        <tbody id="listJawabanLatihanTable">

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
    <jsp:include page="common/footer.jsp" />
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
        listJawabanLatihan();
        function listJawabanLatihan() {
            $.ajax({
                url: 'jawaban_user_latihan?username=' + parseJwt(token).sub,
                type: 'GET',
                headers: {
                    'Content-type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                success: function (data) {
                    var listPattern = data;
                    var content = '';
                    var modal = '';
                    listPattern.forEach(function (item, index) {
                        soalBygenerateId(item.generateId);
                        content += `<tr>
                                                    <td> ` + (index + 1) + ` </td>
                                                    <td> ` + item.generateId + ` </td>
                                                    <td> ` + item.settingLatihan.namaLatihan + ` </td>
                                                    <td> ` + item.result + ` </td>
                                                    <td> ` + item.totalSoal + ` </td>
                                                    <td class="td-actions">
                                                        <a href="#patternModal` + index + `" data-toggle="modal" class="btn btn-default btn-small"><i class="btn-icon-only icon-eye-open"> </i></a>
                                                    </td>
                                                </tr>`;
                        modal += `<div id="patternModal` + index + `" class="modal modal-lg  hide fade " tabindex="-1" role="dialog" aria-labelledby="patternModalLabel" aria-hidden="true">
                                <div class="modal-dialog ">            
                                    <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                            <h3 id="patternModalLabel">kode soal ` + item.generateId + `</h3>
                                        </div>
                                        <div class="modal-body" id='g`+item.generateId+`'>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                        </div>
                                    </div>
                                </div>`;
                    })
                    $('#listModal').html(modal);
                    $('#listJawabanLatihanTable').html(content);
                }
            });
        }
        function reset() {
            $('#courseType').val('');
            $('#courseLevel').val('');
            listPattern();
        }

        
        function soalBygenerateId(generateId) {
                $.ajax({
                    url: '/bank/findByGenerateId?generateId='+generateId,
                    type: 'GET',
                    headers: {
                        'Content-type': 'application/json',
                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                    },
                    success: function (data) {
                        var content = ``;
                        data.data.forEach(function(item,index){
                            content+=
                            (index+1)+`.<pre>`+item.pattern+`
                                <br/>
<pre><b>Jawaban Benar   : `+item.answer+`
Jawaban Anda    : `+item.userAnswer+`    
</b></pre></pre> `;
                        })
                        $('#g'+generateId).html(content);
                    }
                });
            }
        

    </script>
</body>

<style>
    .modal-lg {
        width: 900px;
        margin-left: -500px;
        /* margin:200px ; */
    }
</style>
</html>