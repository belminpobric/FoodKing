using AutoMapper;

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
