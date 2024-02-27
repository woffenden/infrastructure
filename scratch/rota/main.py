from datetime import date, timedelta
import random

# Define team members
team = ["John", "Paul", "George", "Ringo", "Matt B", "Dom", "Chris", "Alex", "Matt H", "Nick"]

# Define unavailable days
unavailable_days = {
    "Dom": [4], # Friday
    "Chris": [4] # Friday
}

# Function to generate the schedule for a week
def generate_schedule(start_date=date.today()):
  schedule = {}
  for day in range(start_date.weekday(), start_date.weekday() + 5):
    current_date = start_date + timedelta(days=day)
    available_members = [member for member in team if member not in unavailable_days or current_date not in unavailable_days[member]]
    # Randomly choose one member from available ones
    on_call = random.choice(available_members)
    schedule[current_date] = on_call
  return schedule

# Print the schedule for the current week
schedule = generate_schedule()
for date, member in schedule.items():
  print(f"{date.strftime('%A, %B %d')}: {member} is on call")
