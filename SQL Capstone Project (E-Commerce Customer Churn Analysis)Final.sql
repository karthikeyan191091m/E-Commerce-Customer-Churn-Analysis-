USE ecomm;
SET sql_safe_updates = 0;
		SET @ware_house_to_home_avg =round((select AVG(WarehouseToHome) from customer_churn));
		select @ware_house_to_home_avg ;
		update customer_churn
		SET WarehouseToHome= @ware_house_to_home_avg WHERE WarehouseToHome IS NULL;
		SET @HourSpendOnApp =round((select AVG(HourSpendOnApp) from customer_churn));
		select @HourSpendOnApp ;
		UPDATE customer_churn
		SET HourSpendOnApp= @HourSpendOnApp
		WHERE HourSpendOnApp IS NULL;
		SET @OrderAmountHikeFromlastYear_AVG =round((select AVG(OrderAmountHikeFromlastYear) from customer_churn));
		select @OrderAmountHikeFromlastYear_AVG ;
		update customer_churn
		SET OrderAmountHikeFromlastYear= @OrderAmountHikeFromlastYear_AVG
		WHERE OrderAmountHikeFromlastYear IS NULL;
		select OrderAmountHikeFromlastYear from customer_churn;
		SET @DaySinceLastOrder_avg =round((select AVG(DaySinceLastOrder) from customer_churn));
		select @DaySinceLastOrder_avg ;
		update customer_churn
		SET DaySinceLastOrder= @DaySinceLastOrder_avg
		WHERE DaySinceLastOrder IS NULL;
		select DaySinceLastOrder from customer_churn;
		select WarehouseToHome,HourSpendOnApp,OrderAmountHikeFromlastYear,DaySinceLastOrder from customer_churn; 
		Select Tenure, CouponUsed, OrderCount from customer_churn;
		select tenure,count(*) from customer_churn group by tenure order by count(*)desc limit 1;
		set @mode_tenure=(select tenure from customer_churn group by tenure order by count(*) desc limit 1);
		select @mode_tenure;
		update customer_churn
		set tenure = @mode_tenure where tenure is null;
		select tenure from customer_churn;
		select CouponUsed,count(*)from customer_churn group by CouponUsed order by count(*) desc limit 1;
		set @mode_couponused =(select CouponUsed from customer_churn group by CouponUsed order by count(*) desc limit 1);
		select @mode_couponused ;
		update customer_churn 
		set CouponUsed=@mode_couponused where CouponUsed is null;
		select CouponUsed from customer_churn;
		select ordercount,count(*) from customer_churn group by ordercount order by count(*) desc limit 1;
		set @mode_ordercount=(select ordercount from customer_churn group by ordercount order by count(*) desc limit 1);
		update customer_churn 
		set ordercount=@mode_ordercount where ordercount is null ;
select WarehouseToHome from customer_churn;
delete from customer_churn where WarehouseToHome >100;
UPDATE customer_churn SET PreferredLoginDevice = 'Mobile Phone' WHERE PreferredLoginDevice = 'Phone';
UPDATE customer_churn SET PreferedOrderCat = 'Mobile Phone' WHERE PreferedOrderCat = 'Mobile';
UPDATE customer_churn SET PreferredPaymentMode = 'Cash on Delivery' WHERE PreferredPaymentMode = 'COD';
UPDATE customer_churn SET PreferredPaymentMode = 'Credit Card' WHERE PreferredPaymentMode = 'CC';
ALTER TABLE customer_churn RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;
ALTER TABLE customer_churn RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;
ALTER TABLE customer_churn ADD ComplaintReceived VARCHAR(3);
UPDATE customer_churn SET ComplaintReceived = 'Yes' WHERE Complain = 1;
UPDATE customer_churn SET ComplaintReceived = 'No' WHERE Complain = 0;
ALTER TABLE customer_churn ADD ChurnStatus VARCHAR(10);
UPDATE customer_churn SET ChurnStatus = 'Churned' WHERE Churn = 1;
UPDATE customer_churn SET ChurnStatus = 'Active' WHERE Churn = 0;
ALTER TABLE customer_churn DROP COLUMN Churn;
ALTER TABLE customer_churn DROP COLUMN Complain;
SELECT ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY ChurnStatus;
SELECT AVG(Tenure) AS AvgTenure, SUM(CashbackAmount) AS TotalCashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';
SELECT COUNT(*) AS ChurnedWithComplaint FROM customer_churn WHERE ChurnStatus = 'Churned' AND ComplaintReceived = 'Yes';
SELECT COUNT(*) AS TotalChurned FROM customer_churn WHERE ChurnStatus = 'Churned';
SELECT Gender, COUNT(*) AS ComplaintCount
	FROM customer_churn
	WHERE ComplaintReceived = 'Yes'
	GROUP BY Gender;
SELECT CityTier, COUNT(*) AS ChurnedCount
	FROM customer_churn
	WHERE ChurnStatus = 'Churned' AND PreferredOrderCat = 'Laptop & Accessory'
	GROUP BY CityTier
	ORDER BY ChurnedCount DESC
	LIMIT 1;
SELECT PreferredPaymentMode, COUNT(*) AS ModeCount
	FROM customer_churn
	WHERE ChurnStatus = 'Active'
	GROUP BY PreferredPaymentMode
	ORDER BY ModeCount DESC
	LIMIT 1;
SELECT SUM(OrderAmountHikeFromlastYear) AS TotalHike
	FROM customer_churn
	WHERE MaritalStatus = 'Single' AND PreferredOrderCat = 'Mobile Phone';
SELECT AVG(NumberOfDeviceRegistered) AS AvgDevices
	FROM customer_churn
	WHERE PreferredPaymentMode = 'UPI';
SELECT COUNT(*) AS Tier1_Customers 
	FROM customer_churn 
    WHERE CityTier = 1;
SELECT COUNT(*) AS Tier2_Customers 
	FROM customer_churn 
    WHERE CityTier = 2;
SELECT COUNT(*) AS Tier3_Customers 
	FROM customer_churn 
    WHERE CityTier = 3;
SELECT SUM(CouponUsed) AS MaleCoupons 
	FROM customer_churn 
	WHERE Gender = 'Male';
SELECT SUM(CouponUsed) AS FemaleCoupons 
	FROM customer_churn 
	WHERE Gender = 'Female';
SELECT COUNT(*) AS MobilePhoneUsers 
	FROM customer_churn 
    WHERE PreferredOrderCat = 'Mobile Phone';
SELECT MAX(HoursSpentOnApp) AS MaxHours_MobilePhone 
	FROM customer_churn 
    WHERE PreferredOrderCat = 'Mobile Phone';
SELECT COUNT(*) AS LaptopUsers 
FROM customer_churn 
WHERE PreferredOrderCat = 'Laptop & Accessory';
SELECT MAX(HoursSpentOnApp) AS MaxHours_Laptop FROM customer_churn WHERE PreferredOrderCat = 'Laptop & Accessory';
SELECT COUNT(*) AS FashionUsers FROM customer_churn WHERE PreferredOrderCat = 'Fashion';
SELECT MAX(HoursSpentOnApp) AS MaxHours_Fashion FROM customer_churn WHERE PreferredOrderCat = 'Fashion';
SELECT SUM(OrderCount) AS TotalOrderCount
	FROM customer_churn
	WHERE PreferredPaymentMode = 'Credit Card' AND SatisfactionScore = 5;
SELECT COUNT(*) AS TargetCustomers
FROM customer_churn
WHERE HoursSpentOnApp = 1 AND DaySinceLastOrder > 5;
SELECT COUNT(*) AS TargetCustomers
FROM customer_churn
WHERE HoursSpentOnApp = 1 AND DaySinceLastOrder > 5;
SELECT AVG(SatisfactionScore) AS AvgScoreWithComplaint
FROM customer_churn
WHERE ComplaintReceived = 'Yes';
SELECT DISTINCT PreferredOrderCat
FROM customer_churn
WHERE CouponUsed > 5;
SELECT PreferredOrderCat, AVG(CashbackAmount) AS AvgCashback
	FROM customer_churn
	GROUP BY PreferredOrderCat
	ORDER BY AvgCashback DESC
	LIMIT 3;
SELECT DISTINCT PreferredPaymentMode
	FROM customer_churn
	WHERE Tenure = 10 AND OrderCount > 500;
SELECT COUNT(*) AS VeryClose 
	FROM customer_churn 
    WHERE WarehouseToHome <= 5;
SELECT COUNT(*) AS Close 
FROM customer_churn 
WHERE WarehouseToHome > 5 AND WarehouseToHome <= 10;
SELECT COUNT(*) AS Moderate 
FROM customer_churn 
WHERE WarehouseToHome > 10 AND WarehouseToHome <= 15;
SELECT COUNT(*) AS Far 
FROM customer_churn 
WHERE WarehouseToHome > 15;
SELECT AVG(OrderCount) AS AvgOrders FROM customer_churn;
CREATE TABLE customer_returns (
  ReturnID INT,
	CustomerID INT,
		ReturnDate DATE,
			RefundAmount INT
);
INSERT INTO customer_returns VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);
SELECT cr.*, cc.*
FROM customer_returns cr
JOIN customer_churn cc ON cr.CustomerID = cc.CustomerID
WHERE cc.ChurnStatus = 'Churned' AND cc.ComplaintReceived = 'Yes';