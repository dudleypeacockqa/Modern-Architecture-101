# 02: Context Over Dogma

## The Principle

There is no universal "best practice" in software architecture. Every decision must be made in the context of the specific project, including the team's skills, the budget, the timeline, the business requirements, and the existing technology landscape. What works for a large technology company with unlimited resources may not work for a small startup with a limited budget and a tight deadline.

## The Danger of Dogma

The software industry is full of dogma. We are constantly told that we must use a certain technology, follow a certain pattern, or adopt a certain methodology. While these recommendations can be valuable, they should never be followed blindly. The architect's job is to understand the trade-offs of each decision and to make the choice that is best for the specific context.

## Examples of Context-Dependent Decisions

### Monolith vs. Microservices

**Dogma:** "Microservices are always better than monoliths."

**Reality:** Microservices introduce significant complexity in terms of deployment, monitoring, and inter-service communication. For a small team building a new application, a well-designed monolith is often a better choice. Microservices should be considered when the team has grown, the application has become more complex, and the benefits of independent deployment and scaling outweigh the costs of the added complexity.

### SQL vs. NoSQL

**Dogma:** "NoSQL databases are always faster and more scalable than SQL databases."

**Reality:** SQL databases have been optimized for decades and can handle enormous scale when properly configured. NoSQL databases offer flexibility and horizontal scalability, but they sacrifice some of the consistency guarantees and query capabilities of SQL databases. The choice should be based on the specific data model and access patterns of the application.

### Cloud vs. On-Premises

**Dogma:** "Everything should be in the cloud."

**Reality:** The cloud offers many benefits, including scalability, flexibility, and reduced operational overhead. However, it can also be more expensive than on-premises infrastructure, especially for predictable, steady-state workloads. For some organizations, a hybrid approach or even a fully on-premises solution may be more cost-effective.

## How to Make Context-Aware Decisions

1.  **Understand the Context:** Before making any architectural decision, take the time to fully understand the context. This includes the business requirements, the team's skills, the budget, the timeline, and the existing technology landscape.

2.  **Identify the Trade-Offs:** Every decision involves trade-offs. Identify the pros and cons of each option and how they align with the specific context.

3.  **Challenge Assumptions:** Don't assume that what worked in the past will work in the future, or that what works for one project will work for another. Challenge your assumptions and be willing to change your mind based on new information.

4.  **Document Your Reasoning:** Use Architecture Decision Records (ADRs) to document the context, the options considered, and the reasoning behind your decision. This will help future team members understand why the decision was made and will make it easier to revisit the decision if the context changes.

By prioritizing context over dogma, we can make architectural decisions that are truly fit for purpose, rather than blindly following the latest trends.
