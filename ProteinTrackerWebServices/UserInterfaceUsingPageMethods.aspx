<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInterfaceUsingPageMethods.aspx.cs" Inherits="ProteinTrackerWebServices.UserInterfaceUsingPageMethods" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript">

        var _users;

        $(document).ready(function () {
            $("#select-user").change(function () {
                UpdateUserData();
            });
            PopulateSelectUsers();
        });

        function PopulateSelectUsers(){
        
        var selectUser = $('#select-user');

        selectUser.empty();
            PageMethods.ListUsers(function (users) {

                _users = users;
            for(var i=0; i < users.length; i++){
                selectUser.append($("<option></option>")
                    .attr("value",users[i].UserId)
                    .text(users[i].Name));
            }
        });
        
        }

        function AddNewUser() {
           var name =  $("#name").val();
           var goal =  $("#goal").val();

            PageMethods.AddUser(name, goal, function () {
                PopulateSelectUsers();
            });
        }

        function AddNewUserUsingJquery() {
           var name =  $("#name").val();
           var goal =  $("#goal").val();

            $.ajax({
                type: "POST",
                //Current URL followed by Methods 
                url: "UserInterfaceUsingPageMethods.aspx/AddUser",
                //Stringify means converting the data into JSON type
                data: JSON.stringify({ 'name': name, 'goal': goal }),
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                success:PopulateSelectUsers
            });
        }

        function AddProtein() {
            var amount =  $("#amount").val();
           var userId =  $("#select-user").val();

            PageMethods.AddProteinToUserId(amount, userId, function (newTotal) {
                $("#user-total").text(newTotal);
            });
        } 

        function UpdateUserData() {
            var index = $("#select-user")[0].selectedIndex;
            if (index < 0) {
                return;
            }

            $("#user-goal").text(_users[index].Goal);
            $("#user-total").text(_users[index].Total);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- When using Page Methods make sure that you've enabled the PageMethods in script manager -->
        <asp:ScriptManager runat="server" EnablePageMethods="true">
            
        </asp:ScriptManager>
        <h1>Protein Tracker</h1>
        <div>
            <label for="select-user">Select User</label>
            <select id="select-user"></select>
        </div>
        <hr />

        <div>
            <h2>ADD NEW </h2>
            <label for="name">Name</label>
            <input type="text" id="name" /> <br />
            <label for="goal">Goal</label>
            <input type="text" id="goal" /> <br />
            <input type="button" id="btn-add-new-user" onclick="AddNewUser()" value="Add" />
            <input type="button" id="btn-add-new-user-using-jquery" onclick="AddNewUserUsingJquery()" value="Add Using Jquery" />

        </div>

        <div>
            <h2>ADD PROTEIN </h2>
            <label for="amount">Amount</label>
            <input type="text" id="amount" /> <br />
            <input type="button" id="btn-add" onclick="AddProtein()" value="Add" />
            

        </div>
        <div>
            Total <span id="user-total"></span><br />
            Goal <span id="user-goal"></span>
        </div>

    </form>
</body>
</html>
