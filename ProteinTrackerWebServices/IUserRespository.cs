using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProteinTrackerWebServices
{
    public interface IUserRespository
    {
        void Add(User user);
        IReadOnlyCollection<User> GetAll();
        User GetById(int Id);
        void Save(User updatedUser);
    }
}
