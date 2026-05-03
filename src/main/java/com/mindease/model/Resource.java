package com.mindease.model;

public class Resource {

    private int resourceId;
    private String title;
    private String description;
    private int categoryId;
    private String url;
    private int addedBy;
    private String addedByName;
    private String authorName;
    private String status;
    private String categoryName;
    private String readTime;
    private String imageUrl;
    private String tags;
    private String colorCode;

    public Resource() {}

    public int getResourceId() { return resourceId; }
    public void setResourceId(int resourceId) { this.resourceId = resourceId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public int getAddedBy() { return addedBy; }
    public void setAddedBy(int addedBy) { this.addedBy = addedBy; }

    public String getAddedByName() { return addedByName; }
    public void setAddedByName(String addedByName) {
        this.addedByName = addedByName;
        this.authorName = addedByName;
    }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
        this.addedByName = authorName;
    }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getReadTime() { return readTime; }
    public void setReadTime(String readTime) { this.readTime = readTime; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public String getColorCode() { return colorCode; }
    public void setColorCode(String colorCode) { this.colorCode = colorCode; }

}

