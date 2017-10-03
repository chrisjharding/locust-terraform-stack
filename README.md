### AWS Locust stack

How this repo works
===

To run your test:
* Edit the `locustfile.py` to define your test bahaviour.
* Edit the config at `main.tf` to configure the amount and size of servers your test will need. (The default is configured low to prevent large accidental billing)
* Spin up the test stack by running `terraform init && terraform apply`. (It will create a separate VPC)
* Start the tests be using the UI available on port `8089` at the master ip (which is output as part of the terraform command).

After you have finished:
* Stop your tests running in the UI
* Run `terraform destroy`

Description:

This terraform is designed to setup a separate vpc for the load testing cluster. You can use it in your own vpc with a bit of modification.
This stack will create a master node and a variable amount of slave nodes. The nodes communicate with each other over the private network but they are placed on a public subnet so there is no extra cost for a nat gateway. You can use the master node to setup all your tests quickly and easily.

Debugging:

An RSA keypair is generated when these instanes are started. You can ssh onto an instance using this key as it is output as part of the terraform apply step.

This repo uses terraform to setup all the networking bits (utilising terraform registry modules). It creates an open security group for port 8089. Please note, this stack is built for load testing purposes only! This should not be used as a template for a production aws system.

Inportant:

Do not use this a template for a live system, this is only for load testing.
Please also be aware that depending on your configuration, it can become expensive to run this stack so don't forget to shut it down! By using this software, you agree that you use it at your own risk and I (the creator) am not liable for any expenses incurred (planned or otherwise) as a result of using this repo. The default configuration is set low so won't incur much of a cost (but this also depends on the load you're throwing at it). You might also want to ensure that the host you are pointing this stack at is owned by you as you could cause an outtage.
