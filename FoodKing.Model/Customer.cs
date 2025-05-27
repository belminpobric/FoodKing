using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model
{
    public class Customer
    {
        public int Id { get; set; }

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
        public string PhoneNumber { get; set; } = null!;

        public string Email { get; set; } = null!;
        public string? Photo { get; set; }
        public string? Address { get; set; }
        public string? Username { get; set; }


    }
}
