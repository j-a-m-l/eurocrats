config/initializers/eurocrats.rb
--------------------------------
Configures the default supplier (the person or company that sells something or provides a service).
That configuration is used later (`Eurocrats.defaul_supplier`) in the controller.

app/controllers/my_simple_controller.rb
---------------------------------------
This controller executes a payment, using an invented `MyPayment` class for performing it.
If it fails it does not handle all different errors.
