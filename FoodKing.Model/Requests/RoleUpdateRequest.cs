using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class RoleUpdateRequest
    {
        public string Name { get; set; } = null!;
        public DateTime updatedAt { get; set; } = DateTime.Now;
    }
}
