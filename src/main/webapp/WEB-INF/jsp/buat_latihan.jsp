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
    <link href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/styles/github.min.css' rel="stylesheet" />
    <script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/highlight.min.js'></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body>
    <jsp:include page="common/navbar.jsp" />
    <div class="main">
        <div class="main-inner">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <div class="widget">
                            <div class="widget-header"> <i class="icon-search"></i>
                                <h3>Buat Latihan</h3>
                            </div>
                            <!-- /widget-header -->
                            <!-- /widget -->
                            <div class="widget-content">
                                <div class="row">
                                    <input type="hidden" class="span5" id="idLatihan" />
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="namaLatihan">Nama Latihan</label>
                                            <div class="controls">
                                                <input type="text" class="span5" id="namaLatihan" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="jumlahSoal">Jumlah Soal</label>
                                            <div class="controls">
                                                <input type="text" class="span5" id="jumlahSoal" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="pola">Pola</label>
                                            <div class="controls">
                                                <input type="text" class="span5" id="pola" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="status">Status</label>
                                            <div class="controls">
                                                <select class="span5" id="status">
                                                    <option value="1">Active</option>
                                                    <option value="0">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary" onclick="saveLatihan()">Save</button>
                                <button class="btn btn-danger" onclick="reset()">Reset</button>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="span12">
                                    <div class="widget widget-table action-table ">
                                        <div class="widget-header"> <i class="icon-th-list"></i>
                                            <h3>List Latihan</h3>
                                        </div>
                                        <!-- /widget-header -->
                                        <div class="widget-content">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th> NO </th>
                                                        <th> ID Latihan </th>
                                                        <th> Nama Latihan </th>
                                                        <th> Jumlah Soal </th>
                                                        <th> Pola Latihan</th>
                                                        <th> Status </th>
                                                        <th> Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="listPatternTable">

                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- /widget-content -->
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
    <div id="previewModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="previewModalLabel"
        aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
            <h3 id="previewModalLabel"></h3>
        </div>
        <div class="modal-body">
            <div id="previewCode"></div>
            <h5>Answer</h5>
            <pre id="answerCode"></pre>
        </div>
        <div class="modal-footer">
            <button class="btn btn-info" aria-hidden="true" onclick="generatePDF()">Download</button>
            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Close</button>
        </div>
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
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script>

        listPattern();
        function listPattern() {
            $.ajax({
                url: '/get_setting_latihan',
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
                        var desc = ``;
                        content += `<tr>
                                        <td> ` + (index + 1) + ` </td>
                                        <td> ` + item.id + ` </td>
                                        <td> ` + item.namaLatihan + ` </td>
                                        <td> ` + item.jumlahSoal + ` </td>
                                        <td> ` + item.pola + ` </td>
                                        <td> ` + item.status + ` </td>
                                        <td class="td-actions">
                                            <a href="#" onclick="getById(`+ item.id + `)"  class="btn btn-default btn-small"><i class="btn-icon-only icon-gear"> </i></a>
                                            <a href="#" onclick="deleteById(`+ item.id + `)"  class="btn btn-default btn-small"><i class="btn-icon-only icon-trash"> </i></a>
                                        </td>
                                    </tr>`;


                    })
                    $('#listPatternTable').html(content);
                }
            });
        }

        
        function getById(id) {
            $.ajax({
                url: '/get_setting_latihan_by_id/' + id,
                type: 'GET',
                headers: {
                    'Content-type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                success: function (data) {
                    data = data.data
                    $('#jumlahSoal').val(data.jumlahSoal);
                    $('#namaLatihan').val(data.namaLatihan);
                    $('#pola').val(data.pola);
                    $('#idLatihan').val(id);
                    $('#status').val(data.status);
                    $('#btnPreview').css('visibility', 'hidden');
                }
            });
        }

        function deleteById(id) {
            $.ajax({
                url: '/delete_setting_latihan_by_id/' + id,
                type: 'GET',
                headers: {
                    'Content-type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                success: function (data) {
                    listPattern()
                }
            });
        }

        function reset() {
            $('#jumlahSoal').val('');
            $('#namaLatihan').val('');
            $('#pola').val('');
            $('#idLatihan').val('');
            $('#status').val(1);            
            $('#btnPreview').css('visibility', 'hidden');
            listPattern();
        }

        function loadingButton(id, isActive) {
            if (isActive) {
                $('#' + id).addClass('loading');
            } else {
                $('#' + id).removeClass('loading');
            }

            $('#' + id).attr('disabled', isActive);
        }


        function saveLatihan() {
            var namaLatihan = $('#namaLatihan').val();
            var jumlahSoal = $('#jumlahSoal').val();
            var pola = $('#pola').val();
            var status = $('#status').val();
            var id = $('#idLatihan').val();

            req = {};
            req.id=id;
            req.namaLatihan = namaLatihan;
            req.jumlahSoal = jumlahSoal;
            req.status = status;
            req.pola = pola;
            $.ajax({
                url: 'save_setting_latihan',
                type: 'POST',
                data: JSON.stringify(req),
                headers: {
                    'Content-type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                success: function (data) {
                    swal("Success !", "Berhasil menambah latihan !", "success");
                    listPattern();
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
</body>

</html>