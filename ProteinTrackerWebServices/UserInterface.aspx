<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInterface.aspx.cs" Inherits="ProteinTrackerWebServices.UserInterface" %>

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
            ProteinTrackerWebServices.ProteinTrackingService.ListUsers(function (users) {

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

            ProteinTrackerWebServices.ProteinTrackingService.AddUser(name, goal, function () {
                PopulateSelectUsers();
            });
        }

        function AddProtein() {
            var amount =  $("#amount").val();
           var userId =  $("#select-user").val();

            ProteinTrackerWebServices.ProteinTrackingService.AddProteinToUserId(amount, userId, function (newTotal) {
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
        <asp:ScriptManager runat="server">
            <Services>
                <asp:ServiceReference Path="ProteinTrackingService.asmx" />
            </Services>
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
