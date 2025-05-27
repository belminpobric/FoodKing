using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodKing.Services.Migrations
{
    /// <inheritdoc />
    public partial class CustomerUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "username",
                table: "Customer",
                nullable: true
            );
            migrationBuilder.AddColumn<string>(
                name: "address",
                table: "Customer",
                nullable: true
            );
            migrationBuilder.AddColumn<string>(
                name: "photo",
                table: "Customer",
                nullable: true
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "username",
                table: "Customer"
            );
            migrationBuilder.DropColumn(
                name: "address",
                table: "Customer"
            );
            migrationBuilder.DropColumn(
                name: "photo",
                table: "Customer"
            );
        }
    }
}
