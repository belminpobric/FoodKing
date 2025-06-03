using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.SearchObjects
{
    public class OrderDetailSearchObject : BaseSearchObject
    {
        public string Details { get; set; } = null!;

        public int ProductId { get; set; }

        public int? CustomerId { get; set; }
    }
}
