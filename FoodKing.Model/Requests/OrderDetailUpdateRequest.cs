using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class OrderDetailUpdateRequest
    {
        public string Details { get; set; } = null!;

        public int? ProductId { get; set; }

        public int? CustomerId { get; set; }
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
    }
}
