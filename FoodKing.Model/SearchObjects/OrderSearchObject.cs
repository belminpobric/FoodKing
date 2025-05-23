using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.SearchObjects
{
    public class OrderSearchObject : BaseSearchObject
    {
        public int Id { get; set; }
        public decimal? Price { get; set; }

        public bool? IsAccepted { get; set; }

        //GTE = Greater Than or Equal
        public string? IdGTE { get; set; }

        public string? StateMachine { get; set; }

    }
}
