using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RentABikeWTR_v1_7.Services.Migrations
{
    /// <inheritdoc />
    public partial class TabelaPoruke : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.CreateTable(
                name: "Poruke",
                columns: table => new
                {
                    PorukaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Tekst = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumPoruke = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Poruke", x => x.PorukaId);
                    table.ForeignKey(
                        name: "FK_Poruke_Korisnici_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "KorisnikId");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Poruke_KorisnikID",
                table: "Poruke",
                column: "KorisnikID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            

            

            
        }
    }
}
