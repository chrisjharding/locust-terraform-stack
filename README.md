How this repo works

It uses terraform to setup all the networking bits (currently only one public subnet in one AZ). It also creates a completely open security group. Please note, this stack is built for load testing purposes only! This should not be used as a template for a production aws system.

It then triggers two cloudformation stacks, one to launch the master, the other to launch the workers.
When these stacks are launched, they distribute the locustfile.py and run the locust command under supervisord.
Once complete (this should take a few mins whilst it installs) the dashboard should be available at port 8089 from the master ip which should be output as part of the terraform run.

When terraform runs (run it from the root project directory), it will create a statefile and a .terraform dir. These are needed for it to remember what bits in your aws account are controlled by this project. When you do `terraform destoy` once you've finished, it will use these files to delete the associated infrastructure and ONLY this! If you delete these files, you will have to delete manually. You also need to have aws credentials set for the account you wish it to create the infrastructure in.  

You can adjust the config in variables.tfvars like, number of workers & worker instance type.

Please also be aware that depending on your configuration, it can become expensive to run this stack so don't forget to shut it down! By using this software, you agree that you use it at your own risk and I (the creator) am not liable for any expenses incurred (planned or otherwise) as a result of using this repo. The default configuration is set low so won't incur much of a cost (but this also depends on the load you're throwing at it). You might also want to ensure that the host you are pointing this stack at is owned by you as you could cause an outtage.


To bring up the stack, run: `terraform apply`
To start the tests, use the locust.io dashboard at the master ip.

locustfile.py is currently limited to 4096 bytes.
