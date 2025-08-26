from github import Github

# Replace with your personal access token
GITHUB_TOKEN = "YOUR_PERSONAL_ACCESS_TOKEN"
OWNER = "your-username"  # Replace with your GitHub username
REPO_NAME = "your-repository"  # Replace with your repository name

# Authenticate to GitHub
g = Github(GITHUB_TOKEN)

# Fetch the repository
repo = g.get_repo(f"{OWNER}/{REPO_NAME}")

# Fetch traffic clone stats
try:
    clones = repo.get_clones_traffic()
    total_clones = clones['count']
    unique_clones = clones['uniques']

    # Update README.md
    with open("README.md", "r") as file:
        lines = file.readlines()

    with open("README.md", "w") as file:
        for line in lines:
            if line.startswith("Clone Stats:"):
                file.write(f"Clone Stats: {total_clones} total, {unique_clones} unique\n")
            else:
                file.write(line)

    print("README.md updated with clone stats!")
except Exception as e:
    print(f"Error fetching or updating clone stats: {e}")
