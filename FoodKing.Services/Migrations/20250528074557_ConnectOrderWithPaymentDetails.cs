using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class ConnectOrderWithPaymentDetails : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PaymentDetailId",
                table: "Order",
                nullable: true
                );
            migrationBuilder.AddForeignKey(
                    name: "Order_PaymentDetails_FK",
                    table: "Order",
                    column: "PaymentDetailId",
                    principalTable: "PaymentDetails",
                    principalColumn: "Id"
                );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PaymentDetailId",
                table: "Order");
            migrationBuilder.DropForeignKey(
                name: "Order_PaymentDetails_FK",
                table: "Order");
        }
    }
}
