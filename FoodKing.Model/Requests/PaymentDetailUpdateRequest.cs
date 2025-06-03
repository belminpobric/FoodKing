using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class PaymentDetailUpdateRequest
    {
        public int OrderNumber { get; set; }
        public DateTime updatedAt { get; set; } = DateTime.Now;
    }
}
