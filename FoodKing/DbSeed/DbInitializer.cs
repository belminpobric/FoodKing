using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Net;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
using System.Text;

namespace FoodKing.DbSeed
{
    public class DbInitializer
    {
        public async static Task Initialize(FoodKingContext dbContext)
        {
            ArgumentNullException.ThrowIfNull(dbContext, nameof(dbContext));
            dbContext.Database.EnsureCreated();

            if (await dbContext.Users.AnyAsync() || await dbContext.Customers.AnyAsync() || await dbContext.Products.AnyAsync()) return;
            var product1 = new Product
            {
                Title = "Cheeseburger",
                Photo = "cheeseburger.jpg",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            var product2 = new Product
            {
                Title = "Pizza Margherita",
                Photo = "pizza.jpg",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            dbContext.Products.Add(product1);
            dbContext.Products.Add(product2);
            await dbContext.SaveChangesAsync();

            var customer1 = new Customer
            {
                FirstName = "John",
                LastName = "Doe",
                PhoneNumber = "123456789",
                Email = "john.doe@email.com",
                Username = "johndoe",
                Address = "Main Street 1",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            var customer2 = new Customer
            {
                FirstName = "Jane",
                LastName = "Smith",
                PhoneNumber = "987654321",
                Email = "jane.smith@email.com",
                Username = "janesmith",
                Address = "Second Street 5",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            dbContext.Customers.Add(customer1);
            dbContext.Customers.Add(customer2);
            await dbContext.SaveChangesAsync();


            var orderDetail1 = new OrderDetail
            {
                Details = "No onions",
                ProductId = product1.Id,
                CustomerId = customer1.Id,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                SoftDelete = false
            };
            var orderDetail2 = new OrderDetail
            {
                Details = "Extra cheese",
                ProductId = product2.Id,
                CustomerId = customer2.Id,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                SoftDelete = false
            };
            dbContext.OrderDetails.Add(orderDetail1);
            dbContext.OrderDetails.Add(orderDetail2);
            await dbContext.SaveChangesAsync();

            //orders
            var order1 = new Order
            {
                Price = 12.99m,
                IsAccepted = true,
                StateMachine = "Delivered",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            var order2 = new Order
            {
                Price = 18.50m,
                IsAccepted = false,
                StateMachine = "Initial",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };

            dbContext.Orders.Add(order1);
            dbContext.Orders.Add(order2);
            await dbContext.SaveChangesAsync();

            var orderHasOrderDetail1 = new OrderHasOrderDetail
            {
                OrderId = order1.Id,
                OrderDetailId = orderDetail1.Id,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                SoftDelete = false
            };
            var orderHasOrderDetail2 = new OrderHasOrderDetail
            {
                OrderId = order2.Id,
                OrderDetailId = orderDetail2.Id,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                SoftDelete = false
            };

            dbContext.OrderHasOrderDetails.Add(orderHasOrderDetail1);
            dbContext.OrderHasOrderDetails.Add(orderHasOrderDetail2);
            await dbContext.SaveChangesAsync();

            var paymentDetail1 = new PaymentDetail
            {
                OrderNumber = 1322,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            var paymentDetail2 = new PaymentDetail
            {
                OrderNumber = 2122,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };

            dbContext.PaymentDetails.Add(paymentDetail1);
            dbContext.PaymentDetails.Add(paymentDetail2);
            await dbContext.SaveChangesAsync();

            var password = ComputeHash("admin");

            var user = new User
            {
                FirstName = "Admin",
                LastName = "Admin",
                Password = password,
                UserName = "admin",
                PhoneNumber = "000-000-000",
                Email = "admin@admin.com",
                Address = "Admin Address",
                CurrentAddress = "current address",
                Photo = "pijas"
            };
            dbContext.Users.Add(user);
            await dbContext.SaveChangesAsync();


            var role = new Role
            {
                Name = "Administrator"
            };
            dbContext.Roles.Add(role);


            var userRole = new UserHasRole
            {
                User = user,
                Role = role
            };
            dbContext.UserHasRoles.Add(userRole);

            await dbContext.SaveChangesAsync();
        }

        public static string ComputeHash(string value)
        {
            using var hash = SHA256.Create();
            var byteArray = hash.ComputeHash(Encoding.UTF8.GetBytes(value));
            return Convert.ToHexString(byteArray);
        }
    }
}
