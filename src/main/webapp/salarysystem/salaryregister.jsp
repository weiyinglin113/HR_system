<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>薪资标准登记</title>
    <%@ include file="../pages/base/basePath.jsp" %>
    <link href="../static/css/navigation.css" rel="stylesheet" type="text/css">

    <style type="text/css">
        nav {
            position: relative;
            z-index: 999;
        }

        .main {
            width: 1200px;
            margin: 60px auto;
            padding: 10px 0;
            background-color: rgb(94, 254, 244);
        }

        .main p {
            margin-bottom: 10px;
        }
        .main .second-p {
            text-align: center;
        }

        .main .btn {
            text-align: right;
            margin-bottom: 10px;
        }

        .main .btn input {
            width: 60px;
            height: 30px;
            font-size: 17px;
        }

        .main table {
            border-collapse: collapse;
            text-align: center;
        }

        .main table tr td {
            border: 2px #000000 solid;
            background-color: #98F6C7;
        }

        /*#4cfa65*/
        .main .second-op, .main .third-op, .main .job-op {
            display: none;
        }

        .main table textarea {
            font-size: 15px;
            font-family: "Microsoft YaHei UI";
        }

        .main table tr td input {
            border: none;
        }
    </style>

</head>

<body onload="startTime()">

<%@ include file="/pages/common/navi.jsp" %>

<div class="main">
    <p>您正在做的业务是：人力资源>>薪资标准管理>>薪资标准登记</p>
<c:if test = '${!(sessionScope.user.role.equals("薪资专员")||sessionScope.user.role.equals("薪资经理"))}'>
    <div class = "msg">
        <p class = "second-p">你没有权限查看该页面！<a href = "pages/user/index.jsp">返回首页</a></p>
    </div>
</c:if>

<c:if test = '${sessionScope.user.role.equals("薪资专员")||sessionScope.user.role.equals("薪资经理")}'>
<form action="salInfo/register" method="post">
        <table>
            <%--            <tr>onchange="changeSecond()--%>
            <%--                薪资标准编号--%>
            <tr>
                <td style="width: 170px">薪酬标准编号</td>
                <td style="width: 230px">
                    <input type="text" id="salaryId" name="salaryId" value="${sessionScope.randomcode}"
                           readonly="readonly"
                           style="width: 100%; height: 25px ;text-align: center;">
                </td>
                <%--薪资标准名称--%>
                <td style="width: 170px">薪酬标准名称</td>
                <td style="width: 230px">
                    <select id="second" name="salaryname" required="required"
                            onkeyup="this.value=this.value.replace(/\s+/g,'')" onchange="setbasic()"
                            style="width: 100%; height: 25px;text-align: center">
                        <option value=''></option>
                        <option index="1" value="软件设计师">软件设计师</option>
                        <option index="2" value="软件分析师">软件分析师</option>
                        <option index="3" value="信息安全工程师">信息安全工程师</option>
                        <option index="4" value="运维工程师">运维工程师</option>
                        <option index="5" value="项目经理">项目经理</option>
                        <option index="6" value="软件架构师">软件架构师</option>
                        <option index="7" value="数据库管理员">数据库管理员</option>
                        <option index="8" value="测试工程师">测试工程师</option>
                        <option index="9" value="销售经理">销售经理</option>
                        <option index="10" value="销售助理">销售助理</option>
                    </select>
                </td>

                <%--薪资金额--%>
                <td style="width: 170px ">薪酬金额(<span style="color: red">￥</span>)</td>
                <td style="width: 230px">
                    <input type="text" id="salaryamount" name="salaryamount" readOnly=readOnly value="0.00"
                           style="width: 100%; height: 25px ;text-align: center; color: gray">
                </td>
            </tr>

            <%--                制订人--%>
            <tr>
                <td style="width: 170px">制定人</td>
                <td style="width: 230px">
                    <input type="text" name="enacters" required="required" maxLength={6}
                           placeholder="请输入"
                           onkeyup="this.value=this.value.replace(/\s+/g,'')"
                           style="width: 100%; height: 25px;text-align: center;" onkeydown="keydown()">
                </td>
                <%--登记人--%>
                <td style="width: 170px">登记人</td>
                <td style="width: 230px">
                    <input type="text" name="registrar" onkeyup="this.value=this.value.replace(/\s+/g,'')"
                           required="required" value="${sessionScope.user.username}"
                           style="width: 100%; height: 25px;text-align: center;" onkeydown="keydown()">
                </td>
                <%--登记时间--%>
                <td style="width: 170px"> 登记时间</td>
                <td style="width: 230px ;background-color:white">
                    <span id="time" name="register_time" style="height: 25px"></span>
                </td>
            </tr>
            <%--                序号--%>
            <tr>
                <td colspan="2">序号</td>

                <%--薪酬项目名称--%>
                <td colspan="2">薪资项目名称<span
                        style="font-size:10px ;color: red ;font-family: 方正少儿简体; ">（三险一金根据计算基本工资自动得出）</span></td>

                <%--金额--%>
                <td colspan="2">金额(<span style="color: red">￥</span>)</td>
            </tr>
            <%--基本工资--%>
            <tr>
                <td colspan="2">1</td>
                <td colspan="2">
                    基本工资
                </td>
                <td colspan="2"><input type="text" id="basicsalary" name="basicsalary" required="required" value="0.00"
                                       onchange="setsal(this);" onfocus="benull_b()" onkeydown="keydown(event)"
                                       style="width: 100%; height: 25px;background-color: #98F6C7 ;text-align: center; color: gray">
                </td>
            </tr>
            <%--交通补助--%>
            <tr>
                <td colspan="2">2</td>
                <td colspan="2">
                    交通补助
                </td>
                <td colspan="2"><input id="Transportation_sal" type="text" name="Transportation_sal" required="required"  value="0.00"
                                       style="width: 100%; height: 25px;background-color: #98F6C7 ;text-align: center; color: gray"
                                       onchange="setsal(this)" onfocus="benull_T()" onkeydown="keydown(event)">
                </td>
            </tr>
            <%--年薪补助--%>
            <tr>
                <td colspan="2">3</td>
                <td colspan="2">
                    年薪补助
                </td>
                <td colspan="2"><input id="Yeal_end_sal" type="text" name="Year_end_sal"required="required" onchange="setsal(this)"
                                       onkeydown="keydown(event)"
                                       onfocus="benull_Y()" value="0.00"
                                       style="width: 100%; height: 25px ;background-color: #98F6C7 ;text-align: center;color: gray">
                </td>
            </tr>
            <%--通信补助--%>
            <tr>
                <td colspan="2">4</td>
                <td colspan="2">
                    通信补助
                </td>
                <td colspan="2"><input id="phone_sal" type="text" name="phone_sal" onchange="setsal(this)"
                                       onkeydown="keydown(event)"
                                       onfocus="benull_p()" value="0.00"
                                       style="width: 100%; height: 25px ;background-color: #98F6C7 ;text-align: center; color: gray;">
                </td>
            </tr>
            <%--养老保险--%>
            <tr>
                <td colspan="2">5</td>
                <td colspan="2">
                    养老保险
                </td>
                <td colspan="2">
                    <input type="text" id="oldAge_sal" name="oldAge_sal" readOnly=readOnly value="0.00"
                           onchange="setsal(this)"
                           style="width: 100%; height: 25px ;background-color: #98F6C7 ;text-align: center;color: gray">
                </td>
            </tr>
            <%--失业保险--%>
            <tr>
                <td colspan="2">6</td>
                <td colspan="2">
                    失业保险
                </td>
                <td colspan="2"><input type="text" id="unemployment_sal" name="unemployment_sal" readOnly=readOnly
                                       onchange="setsal(this)"
                                       value="0.00"
                                       style="width: 100%; height: 25px ;background-color: #98F6C7 ;text-align: center; color: gray">
                </td>
            </tr>
            <%--            医疗保险--%>
            <tr>
                <td colspan="2">7</td>
                <td colspan="2">
                    医疗保险
                </td>
                <td colspan="2"><input type="text" id="health_sal" name="health_sal" readOnly=readOnly value="0.00"
                                       onchange="setsal(this)"
                                       style="width: 100%; height: 25px ;background-color: #98F6C7;text-align: center;;color: gray;">
                </td>
            </tr>
            <%--            住房公积金--%>
            <tr>
                <td colspan="2">8</td>
                <td colspan="2">
                    住房公积金
                </td>
                <td colspan="2"><input id="housing_sal" type="text" name="housing_sal" readOnly=readOnly value="0.00"
                                       onchange="setsal(this)"
                                       style="width: 100%; height: 25px;background-color: #98F6C7;text-align: center; color: gray;">
                </td>
            </tr>

            <div class="btn">
                <input type="submit" value="提交" onclick="notnull()">
                <input type="reset" value="清除">
            </div>

        </table>
    </form>
    </c:if>
</div>
<!--[if lt IE 9]>
<script type="text/javascript">
    jQuery(function ($) {
        var el;
        $("select").each(function () {
            el = $(this);
            el.data("origWidth", el.css("width"));
            // el.data("oriWidth",85);
        })
                .focusin(function () {
                    el = $(this);
                    el.css("width", "auto");

                    //if(el.width() < el.data("oriWidth")){
                    //    el.css("width", el.data("origWidth"));
                    //}

                })
                .bind("blur change ", function () {
                    el = $(this);
                    el.css("width", el.data("origWidth"));
                });
    });
</script>
<![endif]-->
<script>

    // creatcode code=new creatcode();
    // String randomcode= creatcode.getCurrentDateStr();
    // session.setAttribute("randomcode",randomcode);
    // 构建方法
    // function salaryId() {
    //     int num = 1 + Math.random() * 10;
    //     var time = new Date();//new出当前时间
    //     var h = time.getFullYear();
    //     var m = time.getMonth() + 1;
    //     var d = time.getDate();
    //     var H = time.getHours();
    //     var M = time.getMinutes();
    //     var S = -time.getSeconds();
    //     return "ZY" + "h" + "m" + "s" + "H" + "M" + "S"+num;
    // }
    // document.getElementById("salaryId").value=salaryId();

    function notnull() {
        var obj = document.getElementById('salaryname'); //定位id

        var index = obj.selectedIndex; // 选中索引

        var text = obj.options[index].text; // 选中文本
        if (text === "请选择") {
            alert("请选择薪酬名称！")
        }
    }

    function benull_b() {
        var basicsalary = document.getElementById("basicsalary");
        basicsalary.value ="";
    }

    function benull_T() {
        var Transportation_sal = document.getElementById("Transportation_sal");
        Transportation_sal.value = '';
    }

    function benull_Y() {
        var Yeal_end_sal = document.getElementById("Yeal_end_sal");
        Yeal_end_sal.value ="";
    }

    function benull_p() {
        var phone_sal = document.getElementById("phone_sal");
        phone_sal.value = "";
    }

    // 自动计算三险一金跟总薪资
    function setsal(obj) {
        var basicsalary = document.getElementById("basicsalary");
        var oldAge_sal = document.getElementById("oldAge_sal");
        var unemployment_sal = document.getElementById("unemployment_sal");
        var salaryamount = document.getElementById("salaryamount");
        var health_sal = document.getElementById("health_sal");
        var housing_sal = document.getElementById("housing_sal");
        var Transportation_sal = document.getElementById("Transportation_sal");
        var phone_sal = document.getElementById("phone_sal");
        var Yeal_end_sal = document.getElementById("Yeal_end_sal");
        basicsalary.style.color = "black"
        salaryamount.style.color = "black";
        oldAge_sal.style.color = "black";
        unemployment_sal.style.color = "black";
        health_sal.style.color = "black";
        housing_sal.style.color = "black";
        switch (Transportation_sal.value ) {
            case(""):
                Transportation_sal.value = "0.00"
                break;
            default:
                Transportation_sal.value = parseFloat(Transportation_sal.value).toFixed(2);
        }
        switch (basicsalary.value ) {
            case(""):
                basicsalary.value = "0.00"
                break;
            default:
                basicsalary.value = parseFloat(basicsalary.value).toFixed(2);
        }
        switch (phone_sal.value ) {
            case(""):
                phone_sal.value = "0.00"
                break;
            default:
                phone_sal.value = parseFloat(phone_sal.value).toFixed(2);
        }
        switch (Yeal_end_sal.value ) {
            case(""):
                Yeal_end_sal.value = "0.00"
                break;
            default:
                Yeal_end_sal.value = parseFloat(Yeal_end_sal.value).toFixed(2);
        }

        salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(Transportation_sal.value) + parseFloat(Yeal_end_sal.value) + parseFloat(phone_sal.value) +
            parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
        oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
        unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
        health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
        housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);

        Transportation_sal.style.color = "black";
        phone_sal.style.color = "black";
        Yeal_end_sal.style.color = "black";




        //  处理全部空格 asicsalary.value.replace(/\s+/g,""）


    }

    // isNaN(Transportation_sal.value=parseFloat(Transportation_sal.value).toFixed(2))?null:parseFloat(Transportation_sal.value).toFixed(2);
    // isNaN(phone_sal.value=parseFloat(phone_sal.value).toFixed(2))?null:parseFloat(phone_sal.value).toFixed(2);
    // isNaN(Yeal_end_sal.value=parseFloat(Yeal_end_sal.value).toFixed(2))?null:Yeal_end_sal.value=parseFloat(Yeal_end_sal.value).toFixed(2);
    function setbasic() {
        var second = document.getElementById("second");
        var basicsalary = document.getElementById("basicsalary");
        var oldAge_sal = document.getElementById("oldAge_sal");
        var unemployment_sal = document.getElementById("unemployment_sal");
        var salaryamount = document.getElementById("salaryamount");
        var health_sal = document.getElementById("health_sal");
        var housing_sal = document.getElementById("housing_sal");
        var Transportation_sal = document.getElementById("Transportation_sal");
        var phone_sal = document.getElementById("phone_sal");
        var Yeal_end_sal = document.getElementById("Yeal_end_sal");
        switch (second.value) {
            case("软件设计师"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 6000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case ("软件分析师"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 8000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case ("信息安全工程师"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 8000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case("运维工程师") :
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 7000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case ("项目经理") :
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 9000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case("软件架构师") :
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 12000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case("数据库管理员"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 6000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case ("测试工程师"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 7500).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case("销售经理"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 8000).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case("销售助理"):
                basicsalary.style.color = "black"
                salaryamount.style.color = "black";
                oldAge_sal.style.color = "black";
                unemployment_sal.style.color = "black";
                health_sal.style.color = "black";
                housing_sal.style.color = "black";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 5500).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02 + 3).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;
            case(""):
                basicsalary.style.color = "gray"
                salaryamount.style.color = "gray";
                oldAge_sal.style.color = "gray";
                unemployment_sal.style.color = "gray";
                health_sal.style.color = "gray";
                housing_sal.style.color = "gray";
                Transportation_sal.style.color = "gray";
                phone_sal.style.color = "gray";
                Yeal_end_sal.style.color = "gray";
                basicsalary.value = (basicsalary.value = 0).toFixed(2);

                oldAge_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2)
                unemployment_sal.value = (parseFloat(basicsalary.value) * 0.02).toFixed(2);
                health_sal.value = (parseFloat(basicsalary.value) * 0.005).toFixed(2);
                housing_sal.value = (parseFloat(basicsalary.value) * 0.08).toFixed(2);
                salaryamount.value = (parseFloat(basicsalary.value) + parseFloat(oldAge_sal.value) + parseFloat(unemployment_sal.value) + parseFloat(health_sal.value) + parseFloat(housing_sal.value)).toFixed(2);
                Transportation_sal.value = (Transportation_sal.value = 0).toFixed(2);
                phone_sal.value = (phone_sal.value = 0).toFixed(2);
                Yeal_end_sal.value = (Yeal_end_sal.value = 0).toFixed(2);
                break;

            default:
                basicsalary.value = (basicsalary.value = 0).toFixed(2);
        }

    }

    function keydown(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
        }
    }

    // 给薪酬标准编号规定薪酬标准名称
    // function changeSecond() {
    //     var second = $('.second-op');
    //     switch ($('#first option:selected').val()) {
    //         case 1:
    //             $('#second').val(0);
    //             second[1].style.display = "block";
    //             break;
    //         case 2:
    //             $('#second').val(0);
    //             second[2].style.display = "block";
    //             break;
    //         case 3:
    //             $('#second').val(0);
    //             second[3].style.display = "block";
    //             break;
    //         case 4:
    //             $('#second').val(0);
    //             second[4].style.display = "block";
    //             break;
    //         case 5:
    //             $('#second').val(0);
    //             second[5].style.display = "block";
    //             break;
    //         case 6:
    //             $('#second').val(0);
    //             second[6].style.display = "block";
    //             break;
    //         case 7:
    //             $('#second').val(0);
    //             second[7].style.display = "block";
    //             break;
    //         case 8:
    //             $('#second').val(0);
    //             second[8].style.display = "block";
    //             break;
    //             case 9:
    //             $('#second').val(0);
    //                 second[9].style.display = "block";
    //             break;
    //             case 10:
    //             $('#second').val(0);
    //                 second[10].style.display = "block";
    //             break;
    //
    //     }
    // }

    function startTime() {

        // var x = document.getElementById("second");
        // x.selectedIndex = -1;
        // x.removeAttribute("disabled");
        var today = new Date();//定义日期对象
        var yyyy = today.getFullYear();//通过日期对象的getFullYear()方法返回年
        var MM = today.getMonth() + 1;//通过日期对象的getMonth()方法返回年
        var dd = today.getDate();//通过日期对象的getDate()方法返回年
        var hh = today.getHours();//通过日期对象的getHours方法返回小时
        var mm = today.getMinutes();//通过日期对象的getMinutes方法返回分钟
        var ss = today.getSeconds();//通过日期对象的getSeconds方法返回秒
        // 如果分钟或小时的值小于10，则在其值前加0，比如如果时间是下午3点20分9秒的话，则显示15：20：09
        MM = checkTime(MM);
        dd = checkTime(dd);
        mm = checkTime(mm);
        ss = checkTime(ss);

        $('#time').html(yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss);
        setTimeout('startTime()', 1000);//每一秒中重新加载startTime()方法
    }

    function checkTime(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

</script>

</body>
</html>
