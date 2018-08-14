using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProteinTrackerWebServices
{
    public partial class UserInterfaceUsingPageMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        // when using the pageMethods, make sure you've set all your method to static
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public static string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public static int AddProtein(int amount)
        {
            UserRepository _repository = new UserRepository();


            var total = 0;

            //if (Session["total"] != null)
            //    total = (int)Session["total"];
            //total += amount;
            //Session["total"] = total;
            return total;

        }
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public static int AddProteinToUserId(int amount, int userId)
        {
            UserRepository _repository = new UserRepository();
            var user = _repository.GetById(userId);
            if (user == null)
                return -1;

            user.Total += amount;
            _repository.Save(user);

            return user.Total;

        }

        [WebMethod(EnableSession = true)]
        public static int AddUser(string name, int goal)
        {
            UserRepository _repository = new UserRepository();
            var user = new User { Goal = goal, Name = name, Total = 0 };
            _repository.Add(user);
            return user.UserId;
        }
        [WebMethod(EnableSession = true)]
        public static List<User> ListUsers()
        {
            UserRepository _repository = new UserRepository();

            return new List<User>(_repository.GetAll());

        }
    }
}