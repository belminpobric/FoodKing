using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class OrderUpdateRequest
    {
        public decimal? Price { get; set; }

        public bool? IsAccepted { get; set; }

        public string? StateMachine { get; set; }
        public DateTime updatedAt { get; set; } = DateTime.Now;
    }
}
