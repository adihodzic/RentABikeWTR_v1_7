using System;
using System.Text;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using Newtonsoft.Json;
using System.Net.Mail;
using RentABikeWTR.Subscriber;
using Org.BouncyCastle.Crypto.Generators;

public class EmailConsumer
{
    private readonly EmailSettings _emailSettings;

    public EmailConsumer(EmailSettings emailSettings)
    {
        _emailSettings = emailSettings;
    }

    public void Start()
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

                Console.WriteLine($"Message received: {message}");

                // Deserialize and process the email
                SendEmail(message);

                try
                {
                    // Assuming `channel` is your IModel instance
                    if (channel != null && channel.IsOpen)
                    {
                        channel.BasicAck(args.DeliveryTag, false);
                    }
                    else
                    {
                        // Recreate the channel or handle the closed channel scenario
                        Console.WriteLine("Channel is not open. Recreating channel...");
                        // Code to recreate channel
                    }
                }
                catch (ObjectDisposedException ex)
                {
                    // Handle the exception, perhaps by recreating the channel
                    Console.WriteLine("Channel was disposed: " + ex.Message);
                }
            };

            channel.BasicConsume(queueName, false, consumer);
            Console.WriteLine("Waiting for messages. Press [enter] to exit.");
        }
    }

    private void SendEmail(string message)
    {
        // Create the email message
        var emailMessage = new MailMessage
        {
            //From = new MailAddress(_emailSettings.SenderEmail, _emailSettings.SenderName),
            From = new MailAddress("appadi172@gmail.com", "help-desk"),
            Subject = "New Message",
            Body = message,
            IsBodyHtml = true,
        };
        emailMessage.To.Add("ahodzic172@gmail.com"); // Change this to recipient address as needed

        using (var smtpClient = new SmtpClient("smtp.gmail.com", 587))
        {
            //smtpClient.Credentials = new System.Net.NetworkCredential(_emailSettings.UserName, _emailSettings.Password);
            smtpClient.Credentials = new System.Net.NetworkCredential("appadi172@gmail.com", "tijxgzdzdzekrtie");

            smtpClient.EnableSsl = true; //_emailSettings.EnableSsl;

            try
            {
                smtpClient.Send(emailMessage);
                Console.WriteLine("Email sent successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to send email: {ex.Message}");
            }
        }
    }
}