using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class SoftDelete : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Customer",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "DailyMenu",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Menu",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "MenuHasProduct",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Order",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "OrderDetail",
                    nullable: true, 
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "OrderHasOrderDetail",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "PaymentDetails",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Product",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Role",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "Staff",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "User",
                    nullable: true,
                    defaultValue: false
                );
            migrationBuilder.AddColumn<bool>(
                    name: "softDelete",
                    table: "UserHasRole",
                    nullable: true,
                    defaultValue: false
                );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(name: "softDelete", table: "Customer");
            migrationBuilder.DropColumn(name: "softDelete", table: "DailyMenu");
            migrationBuilder.DropColumn(name: "softDelete", table: "Menu");
            migrationBuilder.DropColumn(name: "softDelete", table: "MenuHasProduct");
            migrationBuilder.DropColumn(name: "softDelete", table: "Order");
            migrationBuilder.DropColumn(name: "softDelete", table: "OrderDetail");
            migrationBuilder.DropColumn(name: "softDelete", table: "OrderHasOrderDetail");
            migrationBuilder.DropColumn(name: "softDelete", table: "PaymentDetails");
            migrationBuilder.DropColumn(name: "softDelete", table: "Product");
            migrationBuilder.DropColumn(name: "softDelete", table: "Role");
            migrationBuilder.DropColumn(name: "softDelete", table: "Staff");
            migrationBuilder.DropColumn(name: "softDelete", table: "User");
            migrationBuilder.DropColumn(name: "softDelete", table: "UserHasRole");
        }
    }
}
