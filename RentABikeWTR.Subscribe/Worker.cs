namespace RentABikeWTR.Subscribe
{
    using System;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using Microsoft.Extensions.Hosting;
    using Microsoft.Extensions.Logging;
    using RabbitMQ.Client;
    using RabbitMQ.Client.Events;
    using Newtonsoft.Json;
    using System.Net.Mail;
    using RentABikeWTR_v1_7.Services.Database;
    using Tensorflow.Util;

    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        private readonly EmailSettings _emailSettings;
        private IConnection _connection;
        private IModel _channel;
        private readonly object _lock = new object();
        private readonly RentABikeWTR_v1_7Context _context;

        public Worker(ILogger<Worker> logger, EmailSettings emailSettings, RentABikeWTR_v1_7Context context)
        {
            _logger = logger;
            _emailSettings = emailSettings;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            var factory = new ConnectionFactory
            {
                HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
                Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
                UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
                Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
            };

            using (var connection = factory.CreateConnection())
            using (var channel = connection.CreateModel())
            {
                string exchangeName = "direct";
                string routingKey = "email-key";
                string queueName = "email-name";

                channel.ExchangeDeclare(exchange: exchangeName, type: ExchangeType.Direct);
                channel.QueueDeclare(queueName, true, false, false, null);
                channel.QueueBind(queueName, exchangeName, routingKey, null);

                var consumer = new EventingBasicConsumer(channel);
                consumer.Received += (sender, args) =>
                {
                    var body = args.Body.ToArray();
                    string message = Encoding.UTF8.GetString(body);

                    _logger.LogInformation($"Message received: {message}");

                    var emailAddresses = _context.Korisnici
                    .Where(u => u.UlogaID == 4)
                    .Select(c => c.Email)
                    .ToList();
                    foreach (var emailAddress in emailAddresses)
                    {
                        SendEmail(message, emailAddress);
                    }

                    try
                    {
                        channel.BasicAck(args.DeliveryTag, false);
                    }
                    catch (ObjectDisposedException ex)
                    {
                        _logger.LogError("Channel was disposed: " + ex.Message);
                        //InitializeRabbitMQConnection();
                    }
                };

                channel.BasicConsume(queueName, false, consumer);

                _logger.LogInformation("Worker running.");

                // Block the service to keep it running
                await Task.Delay(Timeout.Infinite, stoppingToken);
            }
        }


        //private void InitializeRabbitMQConnection()
        //{
        //    var factory = new ConnectionFactory
        //    {
        //        HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
        //        Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
        //        UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "admin",
        //        Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
        //    };

        //    lock (_lock)
        //    {
        //        _connection?.Dispose();
        //        _channel?.Dispose();

        //        _connection = factory.CreateConnection();
        //        _channel = _connection.CreateModel();

        //        string exchangeName = "direct";
        //        string routingKey = "email-key";
        //        string queueName = "email-name";

        //        _channel.ExchangeDeclare(exchange: exchangeName, type: ExchangeType.Direct);
        //        _channel.QueueDeclare(queueName, true, false, false, null);
        //        _channel.QueueBind(queueName, exchangeName, routingKey, null);
        //    }
        //}
        private void SendEmail(string message, string recipientEmail)
        {
            var emailMessage = new MailMessage
            {
                From = new MailAddress(_emailSettings.SenderEmail, _emailSettings.SenderName),
                Subject = "New Message",
                Body = message,
                IsBodyHtml = true,
            };
            emailMessage.To.Add(recipientEmail);

            using (var smtpClient = new SmtpClient(_emailSettings.SmtpServer, _emailSettings.SmtpPort))
            {
                smtpClient.Credentials = new System.Net.NetworkCredential(_emailSettings.UserName, _emailSettings.Password);
                smtpClient.EnableSsl = _emailSettings.EnableSsl;

                try
                {
                    smtpClient.Send(emailMessage);
                    _logger.LogInformation("Email sent successfully.");
                }
                catch (Exception ex)
                {
                    _logger.LogError($"Failed to send email: {ex.Message}");
                }
            }
        }
    }

}

////////////////////////////////////////////////////

    //public class Worker : BackgroundService
    //{
    //    private readonly ILogger<Worker> _logger;

    //    public Worker(ILogger<Worker> logger)
    //    {
    //        _logger = logger;
    //    }

    //    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    //    {
    //        while (!stoppingToken.IsCancellationRequested)
    //        {
    //            _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
    //            await Task.Delay(1000, stoppingToken);
    //        }
    //    }
    //}