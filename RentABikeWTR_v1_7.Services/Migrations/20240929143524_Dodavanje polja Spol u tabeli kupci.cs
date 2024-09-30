using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class DodavanjepoljaSpolutabelikupci : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Spol",
                table: "Kupci",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 7,
                column: "Spol",
                value: "Muski");

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 8,
                column: "Spol",
                value: "Muski");

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 9,
                column: "Spol",
                value: "Zenski");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Spol",
                table: "Kupci");
        }
    }
}
