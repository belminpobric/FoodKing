using FoodKing;
using FoodKing.DbSeed;
using FoodKing.Filters;
using FoodKing.Services;
using FoodKing.Services.Database;
using FoodKing.Services.OrderStateMachine;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add CORS policy (for development; lock down in production)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy
            .AllowAnyOrigin()    // or .WithOrigins("http://localhost:8080")
            .AllowAnyMethod()    // GET, POST, PUT, DELETE, OPTIONS...
            .AllowAnyHeader();   // Content-Type, Authorization...
    });
});

builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<ICustomerService, CustomerService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<IMenuService, MenuService>();
builder.Services.AddTransient<IDailyMenuService, DailyMenuService>();
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<IPaymentDetailService, PaymentDetailService>();
builder.Services.AddTransient<IRoleService, RoleService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<AcceptedOrderState>();
builder.Services.AddTransient<CanceledOrderState>();
builder.Services.AddTransient<DeliveredOrderState>();
builder.Services.AddTransient<FinishedOrderState>();
builder.Services.AddTransient<InitialOrderState>();
builder.Services.AddTransient<InProgressOrderState>();
builder.Services.AddTransient<UpdatedOrderState>();

// Add controllers with global filters
builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

// Swagger/OpenAPI configuration
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
            },
            Array.Empty<string>()
        }
    });
});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<FoodKingContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddScoped<DbInitializer>();

builder.Services.AddAutoMapper(typeof(IUserService));

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>(
        "BasicAuthentication", null);

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<FoodKingContext>();
    dataContext.Database.Migrate();
}
// Development-only middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    await app.UseItToSeedSqlServer();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();


app.Run();
