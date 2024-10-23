print("hello World")
import plotly.graph

# Example data
categories = ['Category A', 'Category B', 'Category C']
values = [10, 15, 7]

# Create a bar graph
fig = go.Figure(data=[
    go.Bar(name='Values', x=categories, y=values)
])

# Add a title
fig.update_layout(title='Bar Graph Example', xaxis_title='Categories', yaxis_title='Values')

# Show the graph
fig.show()




