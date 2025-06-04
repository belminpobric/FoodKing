using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.SearchObjects
{
    public class StaffSearchObject : BaseSearchObject
    {
        public string? FirstName { get; set; }

        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }

        public bool? isRoleIncluded { get; set; }
    }
}
