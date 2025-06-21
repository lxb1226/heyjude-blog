---
title: "How to Sync Hugo Blog to GitHub Profile"
date: 2025-06-21T22:00:00+08:00
draft: false
tags: ["Hugo", "GitHub", "Blog Sync", "GitHub Actions", "Automation"]
categories: ["Technology", "Blog Setup"]
description: "A detailed tutorial on using GitHub Actions with gautamkrishnar/blog-post-workflow to automatically sync Hugo blog to GitHub Profile, including configuration steps and precautions."
---

## How to Sync Hugo Blog to GitHub Profile

After we have deployed our blog, we want our GitHub profile to automatically update whenever there is a new blog post, so our profile can showcase our latest articles. We can achieve this with `GitHub Actions`.

## Prerequisites

Before you start, please ensure you have completed the following preparations:

- **Hugo Blog**: A Hugo blog set up and hosted in a GitHub repository (such as `username/username.github.io` or a custom repository).
- **GitHub Repository**: A repository for storing your blog source files (e.g., `username/blog`) and a repository for GitHub Pages (e.g., `username/username.github.io`).
- **GitHub Profile README**: The Profile README is enabled on GitHub (create a repository with the same name as your username, such as `username/username`, e.g., [My GitHub Profile](https://github.com/lxb1226/lxb1226)).
- **Basic Git Knowledge**: Understanding how to commit code, configure `.gitignore`, and use GitHub Actions.

## What is blog-post-workflow?

`blog-post-workflow` is a GitHub Action developed by Gautam Krishnar, designed to synchronize the latest blog posts to the GitHub Profile README or other specified locations. It supports multiple blogging frameworks (including Hugo) and retrieves the latest posts by parsing the RSS feed, automatically updating the target file.

## Step 1: Set Up Hugo Blog Repository

1. **Ensure Hugo Blog Generates an RSS Feed**:
   Hugo generates an RSS feed by default (usually located at `public/index.xml`). In your Hugo configuration file (`config.toml` or `config.yaml`), ensure RSS output is enabled:
   ```toml
   [outputs]
   home = ["HTML", "RSS"]
   ```
   After running the `hugo` command, check for the `index.xml` file in the `public` directory.

   Tips: If your blog is multilingual, the RSS feed address should be `https://your-blog-domain/index.xml`, not `https://your-blog-domain/en/index.xml` or `https://your-blog-domain/zh/index.xml`, etc.

2. **Host Blog Content**:
   - Ensure your Hugo blog source files are stored in one repository (e.g., `username/blog`).
   - Static files (the `public` directory) should be pushed to the GitHub Pages repository (e.g., `username/username.github.io`).
   - In the GitHub Pages repository settings, enable GitHub Pages and select the correct branch (usually `main` or `gh-pages`).

3. **Verify Blog Access**:
   Ensure your blog can be accessed via a custom domain (e.g., `https://username.github.io`) or the GitHub Pages default domain.

## Step 2: Set Up GitHub Profile README

1. **Create Profile README Repository**:
   - Create a repository on GitHub that has the same name as your username (e.g., `username/username`).
   - Create a `README.md` file in the root directory of the repository to display your GitHub Profile content.

2. **Add Blog Placeholder**:
   Add a placeholder in `README.md` for dynamically inserting blog articles. For example:
   ```markdown
   ## My Latest Blog Articles
   <!-- BLOG-POST-LIST:START -->
   <!-- BLOG-POST-LIST:END -->
   ```

   The `blog-post-workflow` will replace this placeholder with links to the latest blog articles.

## Step 3: Configure blog-post-workflow

1. **Create GitHub Actions Workflow**:
   In your Profile README repository (`username/username`), create the following directory structure:
   ```
   .github/workflows/blog-post.yml
   ```

2. **Write Workflow File**:
   Add the following content to `blog-post.yml` to configure `blog-post-workflow`:
   ```yaml
   name: Sync Blog to Profile README

   on:
     schedule:
       - cron: "0 0 * * *" # Run once a day
     workflow_dispatch: # Allow manual triggering

   jobs:
     update-readme-with-blog:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: gautamkrishnar/blog-post-workflow@v1
           with:
             feed_list: "https://username.github.io/index.xml" # Replace with your blog RSS address
             max_post_count: 5 # Sync the latest 5 articles
             readme_path: ./README.md # Target README file
             commit_message: "Update README with latest blog posts"
   ```
   - **feed_list**: Replace with your Hugo blog RSS feed address (usually `https://your-blog-domain/index.xml`).
   - **max_post_count**: Set the number of latest articles to display.
   - **readme_path**: Ensure it points to the correct README file path.
   - **commit_message**: Customize commit message.

3. **Commit Workflow File**:
   Commit `blog-post.yml` to your Profile README repository. GitHub Actions will automatically run at midnight (UTC) daily or can be triggered manually through the GitHub Actions panel.

## Step 4: Verify Sync Results

1. **Check GitHub Actions Logs**:
   - Go to the Actions tab of the Profile README repository to see the status of the `Sync Blog to Profile README` workflow.
   - Ensure there are no errors and the workflow completed successfully.
![](https://img.music-poster.art/2025/06/133d3d31fe568cbba71be00326fe6420.png)
   - You can also manually trigger the workflow to check if the README has been updated. Click `Run workflow` to trigger it manually.
   ![](https://img.music-poster.art/2025/06/bd7d8b28b5a2538881cfd90a878dcd8e.png)

2. **View README Update**:
   - Open the `README.md` of the `username/username` repository to check if the `<!-- blog-post-workflow -->` placeholder has been replaced with the latest blog post list.
   - Sample output may look like:
     ```markdown
     ## My Latest Blog Articles
     - [Article Title 1](https://username.github.io/post/xxx) - 2025-06-21
     - [Article Title 2](https://username.github.io/post/yyy) - 2025-06-20
     ```

3. **Access GitHub Profile**:
   Open your GitHub profile page (e.g., `https://github.com/username`) and confirm that the latest blog articles are displayed in the Profile README.
   ![](https://img.music-poster.art/2025/06/332de26f29f6f15ea703b5e8feae913e.png)

## Notes

- **RSS Feed Availability**: Ensure that your blog's RSS feed (`index.xml`) is accessible via a public URL. If the blog is hosted in a private repository, consider switching to a public repository or providing RSS through another means.
- **GitHub Actions Permissions**: Ensure your repository has enabled Actions write permissions (Settings > Actions > General > Allow all actions and reusable workflows).
- **Sync Frequency**: The default setting is to sync once a day, but you can adjust the `cron` expression as needed (e.g., every hour: `0 * * * *`).
- **Debugging**: If syncing fails, check the Actions logs. Common issues include an incorrect RSS address or an incorrect README file path.

---

**Reference Resources**:
- [gautamkrishnar/blog-post-workflow](https://github.com/gautamkrishnar/blog-post-workflow)
- [Hugo Official Documentation](https://gohugo.io/documentation/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)