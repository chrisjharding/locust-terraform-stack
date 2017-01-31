How this repo works

It uses terraform to setup all the networking bits (currently only one public subnet in one AZ). It also create a completely open security group. Please note, this stack is build for load testing purposes only! This should be used as a template for a production aws system.

It then triggers two cloudformation stacks, one to launch the master, the other to launch the workers.
When these stacks are launched they distribute the locustfile.py and run the locust command number supervisord.
Once complete (this should take a few mins whilst it installs) the dashboard should be available at port 8089 from the master ip which should be output as part of the terraform run.

When terraform runs (run it from the root project directory), it will create a statefile and a .terraform dir. These are needed for it to remember what bits in aws are controlled by this project. When you do `terraform destoy` once youve finished, it will use these files to delete the associated infrastructure and ONLY this! If you delete these files, you will have to delete manually. You also need to have aws credentials set for the account you wish it to create the infrastructure in.  

You can adjust the config in variables.tfvars like, number of workers, worker instance type.

Please also be aware that depending on your configuration, it can become expencive to run this stack so don't forget to turn it off! By using this software, you agree that you use it at your own risk and I (the creator) and not liable for any expences occoured as a result of using this (planned or otherwise!). The default configuration is set low so won't incur much of a cost (but this also depends on the load you're throwing through it). You might also want to ensure that the host you are pointing this stack at is owned by you as you could cause an outtage. 


To bring up the stack, run: `terraform apply`
