using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddOrderStateMachine : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                    name: "stateMachine",
                    table: "Order",
                    nullable: true
                );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(name: "stateMachine", table: "Order");
        }
    }
}
