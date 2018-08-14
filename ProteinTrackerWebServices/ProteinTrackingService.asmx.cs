using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace ProteinTrackerWebServices
{

    [WebService(Namespace = "http://reportshack.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ProteinTrackingService : WebService
    {
        private UserRepository _repository = new UserRepository();
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public int AddProtein(int amount) {

            

            var total = 0;

            if (Session["total"] != null)
                total = (int)Session["total"];
            total += amount;
            Session["total"] = total;
            return total;

        }
        [WebMethod(Description = " Add description to explain how this method works", EnableSession = true)]
        public int AddProteinToUserId(int amount, int userId)
        {
            var user = _repository.GetById(userId);
            if (user == null)
                return -1;

            user.Total += amount;
            _repository.Save(user);

            return user.Total;

        }

        [WebMethod(EnableSession =true)]
        public int AddUser(string name, int goal) {

            var user = new User { Goal = goal, Name = name, Total = 0 };
            _repository.Add(user);
            return user.UserId;
        }
        [WebMethod(EnableSession =true)]
        public List<User> ListUsers() {

            
            return new List<User>(_repository.GetAll());

        }
    }
}
