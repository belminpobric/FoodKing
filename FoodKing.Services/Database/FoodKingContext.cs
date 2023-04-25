using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace FoodKing.Services.Database;

public partial class FoodKingContext : DbContext
{
    public FoodKingContext()
    {
    }

    public FoodKingContext(DbContextOptions<FoodKingContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<DailyMenu> DailyMenus { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<MenuHasProduct> MenuHasProducts { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<OrderHasOrderDetail> OrderHasOrderDetails { get; set; }

    public virtual DbSet<PaymentDetail> PaymentDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Staff> Staff { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserHasRole> UserHasRoles { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=.; Database=food_king; User Id=sa; Password=test; TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC07BAC084EB");

            entity.ToTable("Customer");

            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .HasColumnName("firstName");
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .HasColumnName("lastName");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(255)
                .HasColumnName("phoneNumber");
        });

        modelBuilder.Entity<DailyMenu>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__DailyMen__3214EC07286D7484");

            entity.ToTable("DailyMenu");

            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Menu__3214EC07595D505B");

            entity.ToTable("Menu");

            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
        });

        modelBuilder.Entity<MenuHasProduct>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__MenuHasP__3214EC07CEED5881");

            entity.ToTable("MenuHasProduct");

            entity.HasIndex(e => e.MenuId, "IX_MenuHasProduct_menuId");

            entity.HasIndex(e => e.ProductId, "IX_MenuHasProduct_productId");

            entity.Property(e => e.MenuId).HasColumnName("menuId");
            entity.Property(e => e.ProductId).HasColumnName("productId");

            entity.HasOne(d => d.Menu).WithMany(p => p.MenuHasProducts)
                .HasForeignKey(d => d.MenuId)
                .HasConstraintName("MHP_Menu_FK");

            entity.HasOne(d => d.Product).WithMany(p => p.MenuHasProducts)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("MHP_Products_FK");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Order__3214EC07C862C4AB");

            entity.ToTable("Order");

            entity.Property(e => e.IsAccepted).HasColumnName("isAccepted");
            entity.Property(e => e.Price)
                .HasColumnType("decimal(8, 2)")
                .HasColumnName("price");
            entity.Property(e => e.StateMachine).HasColumnName("stateMachine");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OrderDet__3214EC079853F2FB");

            entity.ToTable("OrderDetail");

            entity.HasIndex(e => e.CustomerId, "IX_OrderDetail_customerId");

            entity.HasIndex(e => e.ProductId, "IX_OrderDetail_productId");

            entity.Property(e => e.CustomerId).HasColumnName("customerId");
            entity.Property(e => e.Details)
                .HasMaxLength(255)
                .HasColumnName("details");
            entity.Property(e => e.ProductId).HasColumnName("productId");

            entity.HasOne(d => d.Customer).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_Order_Customer");

            entity.HasOne(d => d.Product).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Order_Product_FK");
        });

        modelBuilder.Entity<OrderHasOrderDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OrderHas__3214EC070C52C7AB");

            entity.ToTable("OrderHasOrderDetail");

            entity.HasIndex(e => e.OrderDetailId, "IX_OrderHasOrderDetail_orderDetailId");

            entity.HasIndex(e => e.OrderId, "IX_OrderHasOrderDetail_orderId");

            entity.Property(e => e.OrderDetailId).HasColumnName("orderDetailId");
            entity.Property(e => e.OrderId).HasColumnName("orderId");

            entity.HasOne(d => d.OrderDetail).WithMany(p => p.OrderHasOrderDetails)
                .HasForeignKey(d => d.OrderDetailId)
                .HasConstraintName("FK_OrderDetail_OHOD");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderHasOrderDetails)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK_Order_OHOD");
        });

        modelBuilder.Entity<PaymentDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PaymentD__3214EC0736A945DA");

            entity.Property(e => e.OrderNumber).HasColumnName("orderNumber");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC075A0A9E2A");

            entity.ToTable("Product");

            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Role__3214EC07BE828660");

            entity.ToTable("Role");

            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Staff>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Staff__3214EC07085DBF73");

            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .HasColumnName("firstName");
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .HasColumnName("lastName");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(255)
                .HasColumnName("phoneNumber");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Users__3214EC07D5F60FCE");

            entity.ToTable("User");

            entity.Property(e => e.Address)
                .HasMaxLength(255)
                .HasColumnName("address");
            entity.Property(e => e.CurrentAddress)
                .HasMaxLength(255)
                .HasColumnName("currentAddress");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .HasColumnName("firstName");
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .HasColumnName("lastName");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .HasColumnName("password");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(255)
                .HasColumnName("phoneNumber");
            entity.Property(e => e.Photo)
                .HasMaxLength(255)
                .HasColumnName("photo");
            entity.Property(e => e.UserName)
                .HasMaxLength(255)
                .HasColumnName("userName");
        });

        modelBuilder.Entity<UserHasRole>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__UserHasR__3214EC07216D1EEB");

            entity.ToTable("UserHasRole");

            entity.HasIndex(e => e.RoleId, "IX_UserHasRole_RoleId");

            entity.HasIndex(e => e.UserId, "IX_UserHasRole_UserId");

            entity.HasOne(d => d.Role).WithMany(p => p.UserHasRoles)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UHR_Role");

            entity.HasOne(d => d.User).WithMany(p => p.UserHasRoles)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UHR_User");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
