using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class ConnectDailyMenuToProducts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DailyMenuHasProduct",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    productId = table.Column<int>(type: "int", nullable: true),
                    dailyMenuId = table.Column<int>(type: "int", nullable: true),
                    softDelete = table.Column<bool>(type: "bit", nullable: true),
                    createdAt = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()"),
                    updatedAt = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DailyMenuHasP__3214EC07CEED5981", x => x.Id);
                    table.ForeignKey(
                        name: "DMHP_DailyMenu_FK",
                        column: x => x.dailyMenuId,
                        principalTable: "DailyMenu",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "DMHP_Products_FK",
                        column: x => x.productId,
                        principalTable: "Product",
                        principalColumn: "Id");
                });
            migrationBuilder.CreateIndex(
                name: "IX_DailyMenuHasProduct_menuId",
                table: "DailyMenuHasProduct",
                column: "dailyMenuId");

            migrationBuilder.CreateIndex(
                name: "IX_DailyMenuHasProduct_productId",
                table: "DailyMenuHasProduct",
                column: "productId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DailyMenuHasProduct");
        }
    }
}
