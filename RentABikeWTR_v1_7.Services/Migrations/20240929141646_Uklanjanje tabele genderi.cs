using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class Uklanjanjetabelegenderi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Kupci_Genderi",
                table: "Kupci");

            migrationBuilder.DropTable(
                name: "Genderi");

            migrationBuilder.DropIndex(
                name: "IX_Kupci_GenderID",
                table: "Kupci");

            migrationBuilder.DropColumn(
                name: "GenderID",
                table: "Kupci");

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 9, 29, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 9, 29, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 9, 29, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 9, 29, 18, 0, 0, 0, DateTimeKind.Unspecified) });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "GenderID",
                table: "Kupci",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Genderi",
                columns: table => new
                {
                    GenderId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivSpola = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Genderi", x => x.GenderId);
                });

            migrationBuilder.InsertData(
                table: "Genderi",
                columns: new[] { "GenderId", "NazivSpola" },
                values: new object[,]
                {
                    { 1, "Muski" },
                    { 2, "Zenski" }
                });

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 7,
                column: "GenderID",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 8,
                column: "GenderID",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Kupci",
                keyColumn: "KupacId",
                keyValue: 9,
                column: "GenderID",
                value: 2);

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 8, 26, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 8, 26, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 8, 26, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 8, 26, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 26, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 26, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 26, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 26, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.CreateIndex(
                name: "IX_Kupci_GenderID",
                table: "Kupci",
                column: "GenderID");

            migrationBuilder.AddForeignKey(
                name: "FK_Kupci_Genderi",
                table: "Kupci",
                column: "GenderID",
                principalTable: "Genderi",
                principalColumn: "GenderId");
        }
    }
}
