using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;
using Stripe;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PoziviDezurnomVoziluController : ControllerBase
    {
        private readonly IPoziviDezurnomVoziluService _service;
        //private readonly ILoginService xservice;

        public PoziviDezurnomVoziluController(IPoziviDezurnomVoziluService service)
        {
            _service = service;

        }

        [HttpGet]
        public List<Model.PoziviDezurnomVozilu> Get([FromQuery] PoziviDezurnomVoziluSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("{id}")]
        public Model.PoziviDezurnomVozilu GetById(int id)
        {
            return _service.GetById(id);

        }
        [HttpPut("{id}")]
        public Model.PoziviDezurnomVozilu Update(int id, [FromBody] PoziviDezurnomVoziluUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        //[HttpPatch("{id}")]
        //public Model.TuristickiVodici Patch(int id, [FromBody] PoziviDezurnomVoziluUpsertRequest request)
        //{
        //    return _service.Patch(id, request);
        //}
        [HttpPost]
        public Model.PoziviDezurnomVozilu Insert(PoziviDezurnomVoziluUpsertRequest request)
        {
            return _service.Insert(request);
        }
        [HttpGet("Pregled")]
        public List<Model.PoziviDezurnomVoziluPregled> GetPoziviPregled([FromQuery] DateTime DatumOd, DateTime DatumDo)
        {
            return _service.GetPoziviPregled(DatumOd, DatumDo);
        }
    }
}
