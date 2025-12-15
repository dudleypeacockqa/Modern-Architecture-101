# ADR 002: Choose Next.js for Frontend Framework

**Date:** 2025-12-15

**Status:** Accepted

**Context:** We need to select a frontend framework for a new project that requires both static site generation (SSG) for marketing pages and server-side rendering (SSR) for a dynamic, user-authenticated dashboard. The project will involve a team with mixed experience levels, and long-term community support is a key consideration.

**Decision:** We will use Next.js as our frontend framework.

**Consequences:** This decision provides us with a versatile framework that supports multiple rendering strategies, a large and active community, and a rich ecosystem of libraries and tools. However, it also means we will need to manage a more complex configuration and be mindful of the potential for increased build times with SSG.

---

## Detailed Sections

### Context and Problem Statement

**Background:** We are building a new web application that has two distinct parts: a public-facing marketing website and a private, user-authenticated dashboard. The marketing site needs to be highly performant and SEO-friendly, while the dashboard will be data-intensive and require server-side rendering for dynamic content.

**Problem:** We need a single, unified framework that can efficiently handle both SSG and SSR, while also providing a good developer experience and a clear path for future growth.

**Constraints:**
- The team has experience with React but is not deeply familiar with any specific meta-framework.
- The project has a tight deadline for the initial launch of the marketing site.
- We need a framework with a strong, stable community and a clear long-term roadmap.

**Assumptions:**
- The application will be deployed on Vercel, the platform built by the creators of Next.js.
- We will need to integrate with a headless CMS for the marketing content and a custom REST API for the dashboard data.

### Considered Options

#### Option 1: Next.js

**Description:** Next.js is a popular, open-source React framework created by Vercel. It is known for its flexibility, offering a range of rendering strategies including SSG, SSR, and Incremental Static Regeneration (ISR). It has a large and active community and a rich ecosystem of libraries and tools.

**Pros:**
- **Versatile Rendering:** Supports SSG, SSR, and ISR, allowing us to use the best rendering strategy for each part of our application.
- **Large Ecosystem:** A vast collection of libraries, tools, and community resources are available.
- **Strong Community Support:** A large and active community ensures that help is readily available and the framework is well-maintained.
- **Vercel Integration:** Seamless deployment and hosting on Vercel, which aligns with our deployment strategy.

**Cons:**
- **Complexity:** The flexibility of Next.js can lead to a more complex configuration and a steeper learning curve for some features.
- **Build Times:** SSG can lead to longer build times for large sites, although this can be mitigated with ISR.

#### Option 2: Remix

**Description:** Remix is a newer React framework that focuses on web standards and a server-centric model. It prioritizes SSR and aims to provide a streamlined developer experience with features like nested routing and built-in data loading.

**Pros:**
- **Simplified Data Loading:** Remix's `loader` and `action` functions provide a clear and simple way to handle data on the server.
- **Nested Routing:** Nested routes and layouts can simplify the management of complex navigation structures.
- **Performance:** Remix's focus on SSR and its efficient data loading can lead to very fast applications.

**Cons:**
- **Smaller Community:** As a newer framework, Remix has a smaller community and ecosystem compared to Next.js.
- **SSR-Focused:** While Remix is excellent for SSR, it does not have the same level of built-in support for SSG as Next.js, which is a requirement for our marketing site.
- **Less Mature:** Being a newer framework, the long-term roadmap and stability are less established than Next.js.

### Decision Outcome

**Chosen Option:** Next.js

**Justification:** We chose Next.js because its support for multiple rendering strategies (SSG, SSR, ISR) is a perfect fit for our project's requirements. The ability to use SSG for the marketing site will ensure optimal performance and SEO, while SSR will provide the dynamic capabilities needed for the user dashboard. The large and active community, extensive ecosystem, and seamless integration with Vercel were also key factors in our decision. While Remix offers a compelling developer experience, its primary focus on SSR and smaller community make it a less suitable choice for this particular project, where both SSG and SSR are critical requirements.

### Consequences

#### Positive Consequences
- We can use a single framework for both the marketing site and the dashboard, reducing complexity and improving consistency.
- The large ecosystem will provide us with a wide range of libraries and tools to accelerate development.
- The strong community support will be a valuable resource for our team.

#### Negative Consequences
- The team will need to learn the nuances of Next.js, including its various rendering strategies and configuration options.
- We will need to carefully manage build times for the marketing site as it grows.

#### Mitigation Strategies
- We will provide training and resources to the team to help them get up to speed with Next.js.
- We will use Incremental Static Regeneration (ISR) to manage build times for the marketing site.
- We will leverage the extensive documentation and community forums for support.

### Related Decisions

- ADR-001: Use React for Frontend Framework

### References

- [Next.js Official Website](https://nextjs.org/)
- [Remix Official Website](https://remix.run/)
- [Hygraph: Remix vs. Next.js](https://hygraph.com/blog/remix-vs-next)
