using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model
{
    public partial class User
    {
        public int Id { get; set; }

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? Email { get; set; } = null!;

        public string? PhoneNumber { get; set; } = null!;

        public string Username { get; set; } = null!;

        public string Address { get; set; } = null!;

        public string CurrentAddress { get; set; } = null!;
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
        public virtual ICollection<UserHasRole> UserHasRoles { get; } = new List<UserHasRole>();

    }
}
