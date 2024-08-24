using EntityModels.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography.X509Certificates;
using Week3EntityFramework.Dtos;

var context = new IndustryConnectWeek2Context();

//var customer = new Customer
//{
//    DateOfBirth = DateTime.Now.AddYears(-20)
//};


//Console.WriteLine("Please enter the customer firstname?");

//customer.FirstName = Console.ReadLine();

//Console.WriteLine("Please enter the customer lastname?");

//customer.LastName = Console.ReadLine();


//var customers = context.Customers.ToList();

//foreach (Customer c in customers)
//{
//    Console.WriteLine("Hello I'm " + c.FirstName);
//}

//Console.WriteLine($"Your new customer is {customer.FirstName} {customer.LastName}");

//Console.WriteLine("Do you want to save this customer to the database?");

//var response = Console.ReadLine();

//if (response?.ToLower() == "y")
//{
//    context.Customers.Add(customer);
//    context.SaveChanges();
//}



var sales = context.Sales.Include(c => c.Customer)
    .Include(p => p.Product).ToList();

var salesDto = new List<SaleDto>();

foreach (Sale s in sales)
{
    salesDto.Add(new SaleDto(s));
}



//context.Sales.Add(new Sale
//{
//    ProductId = 1,
//    CustomerId = 1,
//    StoreId = 1,
//    DateSold = DateTime.Now
//});


//context.SaveChanges();




//Console.WriteLine("Which customer record would you like to update?");

//var response = Convert.ToInt32(Console.ReadLine());

//var customer = context.Customers.Include(s => s.Sales)
//    .ThenInclude(p => p.Product)
//    .FirstOrDefault(c => c.Id == response);


//var total = customer.Sales.Select(s => s.Product.Price).Sum();


//var customerSales = context.CustomerSales.ToList();

//var totalsales = customer.Sales



//Console.WriteLine($"The customer you have retrieved is {customer?.FirstName} {customer?.LastName}");

//Console.WriteLine($"Would you like to updated the firstname? y/n");

//var updateResponse = Console.ReadLine();

//if (updateResponse?.ToLower() == "y")
//{

//    Console.WriteLine($"Please enter the new name");

//    customer.FirstName = Console.ReadLine();
//    context.Customers.Add(customer).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
//    context.SaveChanges();
//}


//1. Using the linq queries retrieve a list of all customers from the database who don't have sales
//Equivalent SQL query to get full name of all customers from database without sales:
//SELECT c.FirstName + ' ' + c.LastName as Fullname
//FROM Customer c
//WHERE c.Id NOT IN
//(
//	SELECT CustomerId
//	FROM Sale
//)

//get inner query first
var customersIDWithSales = context.Sales.
    Select(s => s.CustomerId).
    ToList();

//get outer query
var customers = context.Customers.ToList();

//filter out customers in sales table
var customersWithoutSales = new List<Customer>();

foreach (var c in customers)
{
    if (!customersIDWithSales.Contains(c.Id))
    {
        customersWithoutSales.Add(c);
    }
}
    
//printout to console
foreach (var c in customersWithoutSales)
{
	Console.WriteLine($"Customer {c.FirstName} {c.LastName} does not have any sale");
}


//2. Insert a new customer with a sale record
// Request Customer information, Product and Store IDs. Assuming current date.
// Insert New customer in Customer table, then sale in Sale table with data provided

var customer = new Customer();

Console.WriteLine();
Console.WriteLine("Please enter new customer first name:");

customer.FirstName = Console.ReadLine();

Console.WriteLine("Please enter new customer last name:");

customer.LastName = Console.ReadLine();

Console.WriteLine("Please enter new customer date of birth:");

customer.DateOfBirth = Convert.ToDateTime(Console.ReadLine());

context.Customers.Add(customer);
context.SaveChanges();

var sale = new Sale();

sale.CustomerId = customer.Id;

Console.WriteLine();
Console.WriteLine("Please enter ProductId for sale:");

sale.ProductId = Convert.ToInt32(Console.ReadLine());

Console.WriteLine("Please enter StoreId for sale:");

sale.StoreId = Convert.ToInt32(Console.ReadLine());

Console.WriteLine("Was this product purchased today? (y/n)");

var purchaseResponse = Console.ReadLine();

if (purchaseResponse?.ToLower() == "y")
{
	sale.DateSold = DateTime.Now;
}
else
{
	Console.Write("Please enter purchase date:");
	sale.DateSold = Convert.ToDateTime(Console.ReadLine());
}

context.Sales.Add(sale);
context.SaveChanges();

//3. Add a new store 
// Request Store Name, Location and Continent and add new store

var store = new Store();

Console.WriteLine();
Console.WriteLine("Please enter store name:");

store.Name = Console.ReadLine();

Console.WriteLine("Please enter store location:");

store.Location = Console.ReadLine();

Console.WriteLine("Please enter store continent:");

store.Continent = Console.ReadLine();

context.Stores.Add(store);
context.SaveChanges();

//4. Find the list of all stores that have sales 
//Equivalent SQL query to get store names with sales
//SELECT DISTINCT Store.Name, Store.Location 
//FROM Sale
//JOIN Store 
//ON Store.Id = Sale.StoreId
//WHERE Sale.StoreId IS NOT NULL;
var storesWithSales = context.Sales.
    Join(context.Stores, sale => sale.StoreId, store => store.Id, (sale, store) => new { StoreName = store.Name, StoreLocation = store.Location }).
    Distinct().
    ToList();

Console.WriteLine();

foreach (var s in storesWithSales)
{
    Console.WriteLine($"Store {s.StoreName} located in {s.StoreLocation} has some sales");
}

Console.ReadLine();









