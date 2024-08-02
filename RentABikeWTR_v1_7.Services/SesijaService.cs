using Microsoft.Extensions.Configuration;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class SesijaService : ISesijaService
    {
        static string SessionId = null;

        private readonly HttpClient _client;
        private readonly IConfiguration _configuration; // ovo je zbog upisa strip api key-eva u appsettings.json 

        public SesijaService()
        {
        }

        public SesijaService(HttpClient client, IConfiguration configuration)
        {

            _client = client;
            _configuration = configuration;
        }




        //public async Task<string> CreateCheckout(string nazivBicikla)
        public async Task<string> CreateCheckout(string nazivBicikla)
        {
            //var thisApiUrl = "https://localhost:7136/api";
            var thisApiUrl = "https://localhost:44335/api";
            var s_wasmClientURL = "https://localhost:44335/api";
            //          var values = new Dictionary<string, string>
            //{
            //    { "sessionId", "hello" },
            //    { "thing2", "world" }
            //};

            //          var content = new FormUrlEncodedContent(values);

            //          var response = await _client.PostAsync("https://api.stripe.com/v1/checkout/session", content);

            //          var responseString = await response.Content.ReadAsStringAsync();
            //          //await HttpClient.Post "https://api.stripe.com/v1/checkout/session"
            //          return SessionId;

            var options = new SessionCreateOptions
            {
                // Stripe calls the URLs below when certain checkout events happen such as success and failure.
                //SuccessUrl = $"{thisApiUrl}/checkout/success?sessionId=" + "{CHECKOUT_SESSION_ID}", // Customer paid.

                PaymentMethodTypes = new List<string> // Only card available in test mode?
                {
                    "card"
                },
                LineItems = new List<SessionLineItemOptions>
                {


                    new()
                    {
                        PriceData = new SessionLineItemPriceDataOptions
                        {

                            UnitAmount = 1000,// bicikli.Cijena, // Price is in USD cents.
                            Currency = "BAM",
                            ProductData = new SessionLineItemPriceDataProductDataOptions
                            {
                                Name = nazivBicikla,
                                Description = "Rezervacija bicikla", //bicikli.Naziv,

                                //Images = new List<string> { "https://example.com/t-shirt.png" }
                            },
                        },
                        Quantity = 1

                    },

                },
                Mode = "payment",// One-time payment. Stripe supports recurring 'subscription' payments.
                SuccessUrl = $"https://example.com?sessionId=" + "{CHECKOUT_SESSION_ID}", // Customer paid.
                CancelUrl = $"https://badexample.com/" + "failed",  // Checkout cancelled.
            };

            var service = new SessionService();
            var session = await service.CreateAsync(options);

            return session.Id;

        }
        public async Task<string> xCreateCheckout(string nazivBicikla, string nazivRute, string jezikVodica)
        {
            //var thisApiUrl = "https://localhost:7136/api";
            var thisApiUrl = "https://localhost:7136/api";
            var s_wasmClientURL = "https://localhost:7136/api";


            var options = new SessionCreateOptions
            {
                // Stripe calls the URLs below when certain checkout events happen such as success and failure.
                //SuccessUrl = $"{thisApiUrl}/checkout/success?sessionId=" + "{CHECKOUT_SESSION_ID}", // Customer paid.

                PaymentMethodTypes = new List<string> // Only card available in test mode?
                {
                    "card"
                },
                LineItems = new List<SessionLineItemOptions>
                {


                    new()
                    {
                        PriceData = new SessionLineItemPriceDataOptions
                        {

                            UnitAmount = 3000,// bicikli.Cijena, // Price is in USD cents.
                            Currency = "BAM",
                            ProductData = new SessionLineItemPriceDataProductDataOptions
                            {
                                Name = nazivBicikla + " " + nazivRute, //"Polar Wizard sa turist rutom Gradska",
                                Description = $"Rezervacija bicikla sa turist rutom i vodičem za {jezikVodica} jezik.", //bicikli.Naziv,

                                //Images = new List<string> { "https://example.com/t-shirt.png" }
                            },
                        },
                        Quantity = 1

                    },

                },
                Mode = "payment",// One-time payment. Stripe supports recurring 'subscription' payments.
                SuccessUrl = $"https://example.com?sessionId=" + "{CHECKOUT_SESSION_ID}", // Customer paid.
                CancelUrl = $"https://badexample.com/" + "failed",  // Checkout cancelled.
            };

            var service = new SessionService();
            var session = await service.CreateAsync(options);

            return session.Id;

        }
    }
}
