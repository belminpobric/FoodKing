using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class Menu
    {
        public Menu()
        {
            Administrators = new HashSet<Administrator>();
        }

        public int MenuId { get; set; }
        public double? Price { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int? FoodId { get; set; }

        public virtual FoodItem? Food { get; set; }
        public virtual ICollection<Administrator> Administrators { get; set; }
    }
}
