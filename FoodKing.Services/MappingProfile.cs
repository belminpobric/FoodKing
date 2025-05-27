using AutoMapper;

namespace FoodKing.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.User, Model.User>();
            CreateMap<Model.Requests.UserInsertRequest, Database.User>();
            CreateMap<Model.Requests.UserUpdateRequest, Database.User>();

            CreateMap<Database.Customer, Model.Customer>();
            CreateMap<Model.Requests.CustomerInsertRequest, Database.Customer>();
            CreateMap<Model.Requests.CustomerUpdateRequest, Database.Customer>();

            CreateMap<Database.Menu, Model.Menu>();
            CreateMap<Model.Requests.MenuInsertRequest, Database.Menu>();
            CreateMap<Model.Requests.MenuUpdateRequest, Database.Menu>();

            CreateMap<Database.Order, Model.Order>();
            CreateMap<Model.Requests.OrderInsertRequest, Database.Order>();
            CreateMap<Model.Requests.OrderUpdateRequest, Database.Order>();

            CreateMap<Database.UserHasRole, Model.UserHasRole>();

            CreateMap<Database.Role, Model.Role>();

            //CreateMap<Database.Proizvodi, Model.Proizvodi>();

            //CreateMap<Database.JediniceMjere, Model.JediniceMjere>();

            //CreateMap<Database.VrsteProizvodum, Model.VrsteProizvodum>();
        }
    }
}
