using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class Korekcija2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 1,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 8, 25, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "NajaveOdmora",
                keyColumn: "NajavaOdmoraId",
                keyValue: 2,
                columns: new[] { "PocetakOdmora", "ZavrsetakOdmora" },
                values: new object[] { new DateTime(2024, 8, 25, 13, 40, 0, 7, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 14, 30, 0, 3, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 1,
                column: "VrijemePoziva",
                value: new DateTime(2024, 8, 25, 13, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "PoziviDezurnomVozilu",
                keyColumn: "PozivDezurnomVoziluId",
                keyValue: 2,
                column: "VrijemePoziva",
                value: new DateTime(2024, 8, 25, 12, 40, 0, 7, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 25, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 25, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 25, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4,
                columns: new[] { "VrijemePreuzimanja", "VrijemeVracanja" },
                values: new object[] { new DateTime(2024, 8, 25, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 25, 18, 0, 0, 0, DateTimeKind.Unspecified) });
        }
    }
}
