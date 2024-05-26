using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class XRezervacijeService : IXRezervacijeService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public XRezervacijeService(IMapper mapper, RentABikeWTR_v1_7Context context)
        {
            _context = context;
            _mapper = mapper;

        }
        public List<Model.XRezervacije> Get(XRezervacijeSearchRequest req)//, DateTime DatumDo)//Morao sam spasiti u neki objekat
                                                                          //zato sam kreirao XRezervacijeSearchRequest....jer onako ne bi dobio vrijednost ako bi proslijedio DateTIme a da nije spasen 
                                                                          //u nekom objektu (Klasi).
        {
            //var pdatum = DateTime.Parse(request.DatumOd);
            //var kdatum = DateTime.Parse(request.KD);
            //var query = _context.Rezervacije.AsQueryable();
            //var query = _context.Rezervacije
            //    .Where(x => x.DatumIzdavanja >= DatumOd)
            //    .Where(x => x.DatumIzdavanja <= DatumDo)
            //    .AsQueryable();
            var query = _context.Rezervacije.Where(x => (x.DatumIzdavanja.Date >= req.DatumOd.Date)
                && (x.DatumIzdavanja <= req.DatumDo.Date));
            //query.RezervacijaId
            List<Model.XRezervacije> xrez = new List<Model.XRezervacije>();
            //var xitem = new XRezervacije();
            var lista = query.ToList();
            foreach (var item in lista)
            {
                var xitem = new XRezervacije();
                xitem.RezervacijaId = item.RezervacijaId;
                xitem.KupacId = (int)item.KupacID;
                xitem.CijenaUsluge = item.CijenaUsluge;
                xitem.Datum = item.DatumIzdavanja.Date;
                xrez.Add(xitem);

            }
            return xrez;
        }

    }
}
