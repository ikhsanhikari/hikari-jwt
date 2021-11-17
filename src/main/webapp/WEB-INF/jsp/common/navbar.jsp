<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                    class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span> </a>
            <a class="brand" href="index">Hikari Learning</a>
            <div class="nav-collapse">
                <ul class="nav pull-right">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                                class="icon-cog"></i> Account <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" onclick="changePage(this, 'general-setting')">Settings</a></li>
                            <li><a href="#" onclick="changePage(this, 'help')">Help</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i
                                class="icon-user"></i> <span id="username_profile"></span> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:;">Profile</a></li>
                            <li id="logout"><a href="javascript:;">Logout</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-search pull-right">
                    <input type="text" class="search-query" placeholder="Search">
                </form>
            </div>
        </div>
    </div>
</div>


<div class="subnavbar">
    <div class="subnavbar-inner">
        <div class="container">
            <ul class="mainnav" id="mainnav" onclick="handleActivePage(event)">
                <li ><a href="#" onclick="changePage(this, 'index')"><i class="icon-dashboard"></i><span>Dashboard</span> </a> </li>
                <li><a href="#" onclick="changePage(this, 'create-pattern')"><i class=" icon-plus-sign-alt"></i><span>Create Pattern</span> </a> </li>
                <li><a href="#" onclick="changePage(this, 'list-pattern')"><i class="icon-list-alt"></i><span>List Pattern</span> </a> </li>
                <li><a href="#" onclick="changePage(this, 'generate-pattern')"><i class="icon-print"></i><span>Generate Pattern</span> </a> </li>
                <li><a href="#" onclick="changePage(this, 'exercise')"><i class="icon-terminal"></i><span>Exercise</span> </a> </li>
            </ul>
        </div>
    </div>
</div>
<script>
    var base_url = '/hikari-jwt'
    var token = localStorage.getItem('token');
    
    function fixUrl(obj){
        return obj.replace('//','/');
    }
    function changePage(obj, page) {
        var url = base_url+'/'+page;
        window.location.href = fixUrl(url);
    }

    function parseJwt(token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        var jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    }

    function isActiveToken() {
        if (token == null) {
            return false;
        } else {
            if (parseJwt(token).exp < Date.now() / 1000) {
                localStorage.clear();
                return false;
            } else {
                return true;
            }
        }
    }

    window.onload = function () {
        if (!isActiveToken()) {
            var url =fixUrl(base_url+'/login');
            window.location.href = url;
        }

        var username_profile = document.querySelector('#username_profile');
        var extToken = parseJwt(token);
        username_profile.innerHTML = extToken.sub;

    }

    logout = document.querySelector('#logout');

    logout.addEventListener('click', function () {
        localStorage.removeItem('token');
        window.location.href = fixUrl(base_url+'/login');
    })
</script>