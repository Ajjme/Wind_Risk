import pandas as pd

# Define the wind speeds for the dataset based on the provided information
data = {
    "RCP": ["RCP 4.5", "RCP 8.5"],
    "10 Year Return Period": [118, 122],  # Wind speeds in mph
    "20 Year Return Period": [122, 128],
    "50 Year Return Period": [128, 135],
    "100 Year Return Period": [135, 144],
    "500 Year Return Period": [144, 150],
}

# Create the DataFrame
wind_speed_df = pd.DataFrame(data)

# Display the DataFrame
wind_speed_df