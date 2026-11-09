```{=html}
<%
function authorText(value) {
  if (!value) return "";

  const authors = Array.isArray(value) ? value : [value];

  return authors
    .map(author => {
      if (typeof author === "string") return author;

      if (author && typeof author === "object") {
        if (typeof author.name === "string") return author.name;

        if (author.name && typeof author.name === "object") {
          return [
            author.name.given,
            author.name.family
          ].filter(Boolean).join(" ");
        }

        if (author.literal) return author.literal;
      }

      return "";
    })
    .filter(Boolean)
    .join(", ");
}
%>

<div class="outreach-list list">
<% for (const item of items) { %>
<%
  const icons = Array.isArray(item["product-icons"])
    ? item["product-icons"].slice(0, 2)
    : [];

  const authors = authorText(item.author);
%>
  <div class="outreach-entry" <%= metadataAttrs(item) %>>

    <div class="outreach-icons">
    <% for (const icon of icons) { %>
      <span
        class="outreach-icon"
        role="img"
        aria-label="<%- icon.label || '' %>"
        title="<%- icon.label || '' %>"
      >
        <i
          class="<%- icon.classes || '' %>"
          aria-hidden="true"
        ></i>
      </span>
    <% } %>
    </div>

    <div class="outreach-main">
      <a class="listing-title" href="<%- item.path %>">
        <%= item.title %>
      </a>

      <% if (item.description) { %>
      <div class="listing-description">
        <%= item.description %>
      </div>
      <% } %>
    </div>

    <div class="outreach-meta">
      <% if (item.date) { %>
      <div class="listing-date">
        <%- item.date %>
      </div>
      <% } %>

      <% if (authors) { %>
      <div class="listing-author">
        <%- authors %>
      </div>
      <% } %>
    </div>

  </div>
<% } %>
</div>
```