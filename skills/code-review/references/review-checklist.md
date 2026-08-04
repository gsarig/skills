# Code Review Checklist

Principles to apply when reviewing any PR. Read this before starting a review.

This file is meant to grow with your own lessons: when a review misses something that a standing principle would have caught, add it here. Add stack-specific sections (e.g. `## WordPress`, `## React`) as they accumulate entries.

---

## General

- **Initialize dependencies where they're used, not in callers.** If a method uses a resource (filesystem, API client, DB connection), it should initialize it itself or receive it as a parameter. A caller that sets up a resource "on behalf of" an inner method creates a hidden contract that's easy to break silently.
- **For a behavioral requirement, never approve on static analysis alone.** A diff can be internally correct and never reached: some gate earlier in the runtime path (client-side validation, a filter registered elsewhere, a capability check) can stop the flow before the changed code runs. Trace the requirement's path end-to-end from its entry point, treating claims made earlier in the conversation as unverified input; then either exercise the affected flow locally or state explicitly in the verdict that the review is static-only and the flow is untested.
