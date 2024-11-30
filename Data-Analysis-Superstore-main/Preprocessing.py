# -*- coding: utf-8 -*-
"""
Created on Fri Oct 18 14:49:45 2024

@author: Odoo
"""

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from statsmodels.tsa.arima.model import ARIMA
from pandas.plotting import autocorrelation_plot
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

data = pd.read_excel('Sample - Superstore.xlsx')
data.head()
describe = data.describe()
info = data.info()
data.isnull().sum()

label_encoder = LabelEncoder()
data['Ship Mode'] = label_encoder.fit_transform(data['Ship Mode'])
data['Segment'] = label_encoder.fit_transform(data['Segment'])
data['Category'] = label_encoder.fit_transform(data['Category'])
data['Product ID'] = label_encoder.fit_transform(data['Product ID'])
data['Year'] = pd.to_datetime(data['Order Date']).dt.year
data['month'] = pd.to_datetime(data['Order Date']).dt.month
data['Discount_flag'] = data['Discount'].apply(lambda x: 1 if x > 0 else 0)
#sales_per_month_year = data.groupby(['Year', 'month'])['Sales'].sum().reset_index()
#profit_per_month_year = data.groupby(['Year', 'month'])['Profit'].sum().reset_index()
relation = data[['Year','month','Product ID' , 'Quantity', 'Profit' , 'Sales' , 'Discount_flag','Ship Mode' , 'Segment' , 'Category']]


correlation_matrix = relation.corr()
# Plotting the heatmap
plt.figure(figsize=(10, 8))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Heatmap')
plt.show()

# Profit Margin: Ratio of profit to sales.
data['Profit_Margin'] = data['Profit'] / data['Sales']

#Sales per Quantity: Sales generated per item sold.
data['Sales_per_Quantity'] = data['Sales'] / data['Quantity']

# Grouping by Discount_flag (1 for discounted, 0 for no discount)
avg_sales_per_Discount = data.groupby('Discount_flag')['Sales_per_Quantity'].mean()

print(avg_sales_per_Discount)














