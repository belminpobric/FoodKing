using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Database.Customer, Model.Customer>();
        }
    }
}
