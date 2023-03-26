using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.User, Model.User>();
            CreateMap<Model.Requests.UserInsertRequest, Database.User>();
            CreateMap<Model.Requests.UserUpdateRequest, Database.User>();

            //CreateMap<Database.Proizvodi, Model.Proizvodi>();

            //CreateMap<Database.JediniceMjere, Model.JediniceMjere>();

            //CreateMap<Database.VrsteProizvodum, Model.VrsteProizvodum>();
        }
    }
}
