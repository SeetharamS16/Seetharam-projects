create database logistics;
use logistics;
Create TABLE IF NOT EXISTS Employee_Details(					
  Emp_ID INT(5) NOT NULL,										
  Emp_name VARCHAR(30) NULL,									
  Emp_branch VARCHAR(15) NULL,								   
  Emp_designation VARCHAR(40) NULL,							    
  Emp_addr VARCHAR(100) NULL,									
  Emp_Cont_no VARCHAR(10) NULL,						     		
  PRIMARY KEY (Emp_ID)									    
);

select * from Employee_Details;

CREATE TABLE IF NOT EXISTS Membership(						
  M_ID INT NOT NULL,										
  Start_Date TEXT NULL,										
  End_Date TEXT NULL,										
  PRIMARY KEY (M_ID)										
);

select * from Membership;

CREATE TABLE  customer (							
  Cust_ID INT(4) NOT NULL,
  Membership_M_ID INT NOT NULL,
  Cust_name VARCHAR(30) NULL,									
  Cust_email_id VARCHAR(50) NULL,	
  Cust_type VARCHAR(20) NULL,
  Cust_addr VARCHAR(100) NULL,
  Cust_cont_no VARCHAR (10) NULL,								
  PRIMARY KEY (Cust_ID, Membership_M_ID),						
  CONSTRAINT fk_customer_Membership1							
    FOREIGN KEY (Membership_M_ID)
    REFERENCES Membership (M_ID));
    
CREATE TABLE Shipment_Details(				
  Sd_id VARCHAR(6) NOT NULL,								
  Sd_content VARCHAR(40) NULL,
  Sd_domain VARCHAR(15) NULL,								
  Sd_type VARCHAR(15) NULL,								    
  Sd_weight VARCHAR(10) NULL,								
  Sd_charges INT(10) NULL,									
  Sd_addr VARCHAR(100) NULL,								
  Ds_Addr VARCHAR(100) NULL,								
  Customer_Cust_ID INT(4) NOT NULL,							
  PRIMARY KEY (Sd_id, Customer_Cust_ID),					
  CONSTRAINT fk_Shipment_Customer							
    FOREIGN KEY (Customer_Cust_ID)
    REFERENCES Customer(Cust_ID)
);

CREATE TABLE  Payment_Details(							
  PAYMENT_ID VARCHAR(40) NOT NULL,							
  Amount INT NULL,											
  Payment_Status VARCHAR(10) NULL,							
  Payment_Date TEXT NULL,									
  Payment_Mode VARCHAR(25) NULL,							
  Shipment_Details_Sd_id VARCHAR(6) NOT NULL,						
  Shipment_Details_Customer_Cust_ID INT(4) NOT NULL,						
  PRIMARY KEY (PAYMENT_ID, Shipment_Details_Sd_id, Shipment_Details_Customer_Cust_ID),		  
  CONSTRAINT fk_Payment_Shipment1							
    FOREIGN KEY (Shipment_Details_Sd_id , Shipment_Details_Customer_Cust_ID)
    REFERENCES Shipment_Details (Sd_id ,Customer_Cust_ID));
    
CREATE TABLE IF NOT EXISTS Status(							
  Current_ST VARCHAR(15) NOT NULL,							
  Sent_date TEXT NULL,										
  Delivery_date TEXT NULL,									
  Sh_id VARCHAR(6) NOT NULL,								
  PRIMARY KEY (Sh_id));	
  
CREATE TABLE IF NOT EXISTS Employee_Manages_Shipment(		
  Employee_Details_Emp_ID INT(5) NOT NULL,							
  Shipment_Details_Sd_id VARCHAR(6) NOT NULL,						
  Status_Sh_id VARCHAR(6) NOT NULL,							
  
  PRIMARY KEY (Employee_Details_Emp_ID, Shipment_Details_Sd_id, Status_Sh_id),	

  CONSTRAINT fk_Employee_Manages_Shipment_Employee				
    FOREIGN KEY (Employee_Details_Emp_ID)
    REFERENCES Employee_Details (Emp_ID),
  CONSTRAINT fk_Employee_Manages_Shipment_Shipment1				
    FOREIGN KEY (Shipment_Details_Sd_id)
    REFERENCES Shipment_Details (Sd_id),
  CONSTRAINT fk_Employee_Manages_Shipment_Status1				
    FOREIGN KEY (Status_Sh_id)
    REFERENCES Status (Sh_id)
);
