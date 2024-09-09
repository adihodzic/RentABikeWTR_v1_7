using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class SesijaController : ControllerBase  // novi primjer
    {
        //Bicikli bic = new Bicikli();
        //private readonly IConfiguration _configuration;

        //private static string s_wasmClientURL = string.Empty;



        private readonly ISesijaService _service;

        public SesijaController(ISesijaService service)
        {
            _service = service;
        }
        [HttpPost]
        public async Task<string> CreateCheckout(CheckoutOrderResponse cor, string nazivBicikla, double cijenaBicikla) //cor je ono sto trazi stripe server, a nazivBicikla je nas parametar
        {
            return await _service.CreateCheckout(nazivBicikla, cijenaBicikla);
        }
        [HttpPost("xSesija")]
        public async Task<string> xCreateCheckout(CheckoutOrderResponse cor, string nazivBicikla, string nazivRute, string jezikVodica, double cijenaUsluge)
        {
            return await _service.xCreateCheckout(nazivBicikla, nazivRute, jezikVodica, cijenaUsluge);
        }
        //[HttpGet]
        //public List<Model.Bicikli> Get([FromQuery] BicikliSearchRequest search)
        //{
        //    return _service.Get(search);
        //}
    }
}
