using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model
{
    public class UserHasRole
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int RoleId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        public virtual Role Role { get; set; } = null!;

    }
}
