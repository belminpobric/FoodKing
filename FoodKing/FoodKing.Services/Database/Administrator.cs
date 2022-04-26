using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class Administrator
    {
        public int AdminId { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? Status { get; set; }
        public int? MenuId { get; set; }

        public virtual Menu? Menu { get; set; }
    }
}
