using app.Filters;
using FoodKing.Services;
using FoodKing.Services.Database;
using FoodKing.Services.OrderStateMachine;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<ICustomerService, CustomerService>();
builder.Services.AddTransient<IOrderService, OrderService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<AcceptedOrderState>();
builder.Services.AddTransient<CanceledOrderState>();
builder.Services.AddTransient<DeliveredOrderState>();
builder.Services.AddTransient<FinishedOrderState>();
builder.Services.AddTransient<InitialOrderState>();
builder.Services.AddTransient<InProgressOrderState>();

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<FoodKingContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IUserService));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
