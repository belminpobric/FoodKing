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

            CreateMap<Database.Product, Model.Product>();
            CreateMap<Model.Requests.ProductInsertRequest, Database.Product>();
            CreateMap<Model.Requests.ProductUpdateRequest, Database.Product>();

            CreateMap<Database.PaymentDetail, Model.PaymentDetail>();
            CreateMap<Model.Requests.PaymentDetailInsertRequest, Database.PaymentDetail>();
            CreateMap<Model.Requests.PaymentDetailUpdateRequest, Database.PaymentDetail>();

            CreateMap<Database.Role, Model.Role>();
            CreateMap<Model.Requests.RoleInsertRequest, Database.Role>();
            CreateMap<Model.Requests.RoleUpdateRequest, Database.Role>();


            CreateMap<Database.Staff, Model.Staff>();
            CreateMap<Model.Requests.StaffInsertRequest, Database.Staff>();
            CreateMap<Model.Requests.StaffUpdateRequest, Database.Staff>();

            CreateMap<Database.OrderDetail, Model.OrderDetail>();
            CreateMap<Model.Requests.OrderDetailInsertRequest, Database.OrderDetail>();
            CreateMap<Model.Requests.OrderDetailUpdateRequest, Database.OrderDetail>();

            ////////////////////////////////////////////////////////
            CreateMap<Database.UserHasRole, Model.UserHasRole>();
            CreateMap<Database.OrderHasOrderDetail, Model.OrderHasOrderDetail>();

        }
    }
}
