using FoodKing.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.Messages
{
    public class OrderAccepted
    {
        public Order Order { get; set; }
    }
}
