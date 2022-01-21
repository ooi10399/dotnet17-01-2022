using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PizzaModelsLibrary;

namespace PizzaFEConsoleApp
{
    class Program
    {
        void RegisterCustomers()
        {
            Customer customer = new Customer();
            customer.TakeCustomerDetailFromUser();
        }

        void DisplayCustomer()
        { 
        
        }
        static void Main(string[] args)
        {
            ManageCustomer program = new ManageCustomer();
            program.RegisterCustomer();
            program.DisplayCustomer();
            Console.ReadKey();
        }
    }
}
