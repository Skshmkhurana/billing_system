# Billing System - Rails Application

A comprehensive billing system built with Ruby on Rails that handles product billing, tax calculations, change denominations, and invoice generation.

## Overview

This billing system allows shop owners to:
- Create bills for customers with multiple products
- Automatically calculate taxes for each product
- Calculate change denominations based on available cash in the shop
- Send invoices via email asynchronously
- Track product stock and customer purchases

## Features

### Core Functionality
- **Product Management**: Add products with codes, prices, stock, and tax percentages
- **Bill Generation**: Create bills with multiple products and quantities
- **Tax Calculation**: Automatic tax calculation per product based on tax percentage
- **Change Calculation**: Intelligent change calculation using available denominations
- **Stock Management**: Automatic stock reduction after billing
- **Customer Management**: Customer records based on email addresses
- **Invoice Emails**: Asynchronous email sending using ActiveJob

### User Interface
- **Form Validation**: JavaScript validation for customer email (required and format validation)
- **Dynamic Product Addition**: Add multiple products to a single bill
- **Denomination Management**: View and update available denominations in the shop
- **Bill Display**: Detailed bill view with itemized breakdown and change denominations

## Technology Stack

- **Framework**: Ruby on Rails 8.0.4
- **Database**: PostgreSQL
- **Web Server**: Puma
- **Background Jobs**: Solid Queue (ActiveJob adapter)
- **Caching**: Solid Cache
- **WebSocket**: Solid Cable
- **JavaScript**: Importmap (ESM modules)
- **Frontend**: Turbo Rails, Stimulus

## Project Structure

```
app/
├── controllers/
│   └── bills_controller.rb      # Handles bill creation and display
├── models/
│   ├── bill.rb                  # Bill model with associations
│   ├── bill_item.rb             # Bill items (products in a bill)
│   ├── customer.rb              # Customer model
│   ├── product.rb               # Product model with validations
│   ├── denomination.rb          # Cash denomination model
│   └── payment_breakdown.rb     # Change breakdown by denomination
├── services/
│   ├── billing_calculator.rb    # Calculates bill totals and taxes
│   └── change_calculator.rb     # Calculates change denominations
├── jobs/
│   └── send_invoice_job.rb      # Background job for sending invoices
├── mailers/
│   └── invoice_mailer.rb        # Email invoice generation
└── views/
    └── bills/
        ├── new.html.erb         # Bill creation form
        └── show.html.erb        # Bill display page

db/
├── seeds.rb                     # Seed data for products and denominations
└── migrate/                     # Database migrations
```

## Key Components

### Models

1. **Bill**: Represents a customer bill with total amount and paid amount
2. **BillItem**: Links products to bills with quantity, unit price, and tax
3. **Product**: Products with code, name, price, stock, and tax percentage
4. **Customer**: Customer records identified by email
5. **Denomination**: Available cash denominations (2000, 500, 200, 100, 50, 20, 10)
6. **PaymentBreakdown**: Change breakdown showing denominations used

### Services

1. **BillingCalculator**: 
   - Calculates subtotal for each item (price × quantity)
   - Calculates tax for each item
   - Updates bill total amount
   - Reduces product stock

2. **ChangeCalculator**:
   - Calculates change (paid_amount - total_amount)
   - Uses greedy algorithm to determine denominations
   - Creates payment breakdown records
   - Updates denomination availability

### Background Jobs

- **SendInvoiceJob**: Sends invoice emails asynchronously using ActiveJob and Solid Queue

## Database Schema

### Tables
- `bills`: Customer bills with total and paid amounts
- `bill_items`: Products in each bill with quantities and prices
- `products`: Product catalog with stock and pricing
- `customers`: Customer information
- `denominations`: Available cash denominations
- `payment_breakdowns`: Change breakdown by denomination

## Setup Instructions

### Prerequisites
- Ruby 3.2 or higher
- Rails 8.0.4
- PostgreSQL (9.3 or higher)
- Node.js (for asset pipeline)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd billing_system
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Configure database**
   - Update `config/database.yml` with your PostgreSQL credentials
   - Default configuration:
     - Database: `billing_system_development`
     - Username: `postgres`
     - Password: `password`
     - Host: `localhost`

4. **Create and setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Start the server**
   ```bash
   rails server
   # or
   rails s
   ```

6. **Start background job processor** (in a separate terminal)
   ```bash
   bin/jobs
   ```

7. **Access the application**
   - Open browser: `http://localhost:3000`

## Seed Data

The seed file (`db/seeds.rb`) includes:

### Products (10 items)
- Pen (P001) - ₹10, 5% tax
- Notebook (P002) - ₹50, 10% tax
- Pencil (P003) - ₹5, 5% tax
- Eraser (P004) - ₹8, 5% tax
- Ruler (P005) - ₹25, 10% tax
- Sharpener (P006) - ₹15, 5% tax
- Stapler (P007) - ₹120, 12% tax
- Highlighter (P008) - ₹30, 10% tax
- Marker (P009) - ₹35, 10% tax
- Calculator (P010) - ₹500, 18% tax

### Denominations
- ₹2000, ₹500, ₹200, ₹100, ₹50, ₹20, ₹10
- Each denomination starts with 20 available units

## Usage

### Creating a Bill

1. Navigate to the home page (billing form)
2. Enter customer email (validated for format)
3. Add products:
   - Enter product code (e.g., P001)
   - Enter quantity
   - Click "Add New" to add more products
4. Update available denominations (if needed)
5. Enter paid amount
6. Click "Generate Bill"

### Viewing a Bill

After bill creation, you'll be redirected to the bill details page showing:
- Customer email
- Purchased items with quantities, prices, and taxes
- Total amount
- Paid amount
- Balance (change)
- Change breakdown by denominations

## Form Validation

The billing form includes JavaScript validation:
- **Customer Email**: Required field with email format validation
- **Error Display**: Red error messages appear below the input field
- **Real-time Feedback**: Validation on blur and input events
- **Form Submission**: Prevents submission with invalid data

## Background Jobs

The application uses Solid Queue for background job processing:
- Invoice emails are sent asynchronously
- Jobs are processed by running `bin/jobs` command
- In development, you can run jobs inline or use a separate process

## Configuration

### Database
Edit `config/database.yml` to configure database connections for different environments.

### Email (Production)
Configure email settings in `config/environments/production.rb` or use environment variables.

### Queue Processing
Configure queue settings in `config/queue.yml`:
- Polling interval
- Batch size
- Worker threads and processes

## Development

### Running Tests
```bash
rails test
```

### Code Quality
```bash
# Run RuboCop
bundle exec rubocop

# Run Brakeman (security)
bundle exec brakeman
```

### Console
```bash
rails console
# or
rails c
```

## Production Deployment

The application includes Kamal deployment configuration:
- See `config/deploy.yml` for deployment settings
- Uses Docker containers
- Supports SSL via Let's Encrypt
- Configured for Solid Queue job processing

## Notes

- **Idempotent Seeds**: Seed data uses `find_or_create_by!` to prevent duplicates
- **Stock Management**: Product stock is automatically reduced after billing
- **Denomination Updates**: Available denominations are updated when change is given
- **Email Delivery**: In development, emails are sent synchronously; configure SMTP for production
- **UI Design**: Intentionally simple UI focused on functionality

## Troubleshooting

### Database Connection Issues
- Ensure PostgreSQL is running
- Verify credentials in `config/database.yml`
- Check database exists: `rails db:create`

### Background Jobs Not Processing
- Ensure `bin/jobs` is running in a separate terminal
- Check queue configuration in `config/queue.yml`

### Email Not Sending
- Configure SMTP settings for production
- In development, check logs for email content
- Verify background job processor is running

## License

[Specify your license here]

## Author

[Your name/team]

## Contributing

[Contributing guidelines if applicable]
