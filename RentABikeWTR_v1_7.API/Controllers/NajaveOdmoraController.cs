using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NajaveOdmoraController : ControllerBase
    {

        private readonly INajaveOdmoraService _service;
        //private readonly ILoginService xservice;

        public NajaveOdmoraController(INajaveOdmoraService service)
        {
            _service = service;

        }

        [HttpGet]
        public List<Model.NajaveOdmora> Get([FromQuery] NajaveOdmoraSearchRequest? request)
        {
            return _service.Get(request);
        }
        [HttpGet("Pregled")]
        public List<Model.NajaveOdmoraPregled> GetNajavePregled([FromQuery] DateTime? DatumOd, DateTime? DatumDo)
        {
            return _service.GetNajavePregled(DatumOd, DatumDo);
        }
        [HttpGet("{id}")]
        public Model.NajaveOdmora GetById(int id)
        {
            return _service.GetById(id);

        }

        [HttpPut("{id}")]
        public Model.NajaveOdmora Update(int id, [FromBody] NajaveOdmoraUpsertRequest request)
        {
            return _service.Update(id, request);
        }
        //[HttpPatch("{id}")]
        //public Model.Poslovnice Patch(int id, [FromBody] PoslovniceUpsertRequest request)
        //{
        //    return _service.Patch(id, request);
        //}
        [HttpPost]
        public Model.NajaveOdmora Insert(NajaveOdmoraUpsertRequest request)
        {
            return _service.Insert(request);
        }
    }
}

