using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class createdAtUpdatedAt : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            //createdAt
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Customer",
                nullable: false,
                defaultValueSql:"GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "DailyMenu",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Menu",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "MenuHasProduct",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Order",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "OrderDetail",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "OrderHasOrderDetail",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "PaymentDetails",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Product",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Role",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "Staff",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "User",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "createdAt",
                table: "UserHasRole",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );

            //updatedAt

            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Customer",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "DailyMenu",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Menu",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "MenuHasProduct",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Order",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "OrderDetail",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "OrderHasOrderDetail",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "PaymentDetails",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Product",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Role",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "Staff",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "User",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
            migrationBuilder.AddColumn<DateTime>(
                name: "updatedAt",
                table: "UserHasRole",
                nullable: false,
                defaultValueSql: "GETDATE()"
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(name: "createdAt", table: "Customer");
            migrationBuilder.DropColumn(name: "createdAt", table: "DailyMenu");
            migrationBuilder.DropColumn(name: "createdAt", table: "Menu");
            migrationBuilder.DropColumn(name: "createdAt", table: "MenuHasProduct");
            migrationBuilder.DropColumn(name: "createdAt", table: "Order");
            migrationBuilder.DropColumn(name: "createdAt", table: "OrderDetail");
            migrationBuilder.DropColumn(name: "createdAt", table: "OrderHasOrderDetail");
            migrationBuilder.DropColumn(name: "createdAt", table: "PaymentDetails");
            migrationBuilder.DropColumn(name: "createdAt", table: "Product");
            migrationBuilder.DropColumn(name: "createdAt", table: "Role");
            migrationBuilder.DropColumn(name: "createdAt", table: "Staff");
            migrationBuilder.DropColumn(name: "createdAt", table: "User");
            migrationBuilder.DropColumn(name: "createdAt", table: "UserHasRole");

            migrationBuilder.DropColumn(name: "updatedAt", table: "Customer");
            migrationBuilder.DropColumn(name: "updatedAt", table: "DailyMenu");
            migrationBuilder.DropColumn(name: "updatedAt", table: "Menu");
            migrationBuilder.DropColumn(name: "updatedAt", table: "MenuHasProduct");
            migrationBuilder.DropColumn(name: "updatedAt", table: "Order");
            migrationBuilder.DropColumn(name: "updatedAt", table: "OrderDetail");
            migrationBuilder.DropColumn(name: "updatedAt", table: "OrderHasOrderDetail");
            migrationBuilder.DropColumn(name: "updatedAt", table: "PaymentDetails");
            migrationBuilder.DropColumn(name: "updatedAt", table: "Product");
            migrationBuilder.DropColumn(name: "updatedAt", table: "Role");
            migrationBuilder.DropColumn(name: "updatedAt", table: "Staff");
            migrationBuilder.DropColumn(name: "updatedAt", table: "User");
            migrationBuilder.DropColumn(name: "updatedAt", table: "UserHasRole");
        }
    }
}
