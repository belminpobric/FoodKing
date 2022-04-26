using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class Chef
    {
        public int ChefId { get; set; }
        public string LastName { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string? PhoneNumber { get; set; }
        public string Password { get; set; } = null!;
        public int? OrderId { get; set; }

        public virtual FoodOrder? Order { get; set; }
    }
}
