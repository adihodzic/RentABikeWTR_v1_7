using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class RezervacijeController : ControllerBase
    {
        private readonly IRezervacijeService _service;
        private readonly IXRezervacijeService _xservice;

        public RezervacijeController(IRezervacijeService service, IXRezervacijeService xservice)
        {
            _service = service;
            _xservice = xservice;
        }


        //public class RezervacijeController : BaseCRUDController<Model.Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest>
        //{

        //    public RezervacijeController(ICRUDService<Rezervacije, RezervacijeSearchRequest, RezervacijeUpsertRequest, RezervacijeUpsertRequest> service) : base(service)
        //    {


        //    }
        //}

        [HttpGet]
        public List<Model.RezervacijePregled> Get([FromQuery] RezervacijeSearchRequest search)
        {
            return _service.Get(search);
        }
        [HttpGet("Dostupni")]
        public List<Model.BicikliDostupni> GetRezervacijeDostupni([FromQuery] RezervacijeDostupniSearchRequest request)
        {
            return _service.GetRezervacijeDostupni(request);
        }
        [HttpGet("XRezervacije")]
        public Model.XRezervacijeResult GetXRezervacije([FromQuery] DateTime DatumOd, DateTime DatumDo)
        {
            return _xservice.GetXRezervacije(DatumOd, DatumDo);
        }
        [HttpGet("XKupac")]
        public List<Model.Rezervacije> GetRezervacijeKupac([FromQuery] int id)
        {
            return _service.GetRezervacijeKupac(id);
        }
        [HttpGet("{id}")]
        public Model.Rezervacije GetById(int id)
        {
            return _service.GetById(id);
        }
        [HttpPost]
        public Model.Rezervacije Insert(RezervacijeUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpPost("Mobilna")]
        public Model.Rezervacije InsertMobilna(RezervacijeMobilnaUpsertRequest request)
        {
            return _service.InsertMobilna(request);
        }
        [HttpPut("{id}")]
        public Model.Rezervacije Update(int id, [FromBody] RezervacijeUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        //[HttpGet]
        //public List<Model.Rezervacije> Get([FromQuery] RezervacijeDatumSearchRequest search)
        //{
        //    return _service.GetPoDatumu(search);

        //}
    }
}
