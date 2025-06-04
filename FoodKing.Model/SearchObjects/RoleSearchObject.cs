using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.SearchObjects
{
    public class RoleSearchObject : BaseSearchObject
    {
        public string? Name { get; set; }

        public bool? isRoleIncluded { get; set; }
    }
}
