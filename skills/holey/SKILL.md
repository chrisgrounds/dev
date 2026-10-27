---
name: holey
description: Type-driven implementation
---

# Holey

The user specifies a requirement and your job is to turn it into a set of types and type-signatures (with holes where we lack knowledge), check the code compiles, and then implement the function bodies in parallel with cheap subagents.

## Steps

1. Turn the requirements into a set of types and (pure and impure) functions. Do not implement any functions at this stage - in Haskell use `undefined`, in Rust use `todo!()`, etc, for the implementations. You should only produce types and type-signatures at this point. Use type holes when you are not sure on a type (i.e. Haskell's `_`). Types should be as constraining as possible so that subagents can rely only on types to do implementation.
2. Any invariants that can't be captured in types should be expressed as property-tests.
2. Check the code compiles once you have created all the types and signatures
3. Now we have a set of (ideally mostly pure) functions and at this step you should implement them. Use cheaper subagents and implement the functions in parallel. Each subagent should receive only the information necessary to implement their function.
4. Check the code compiles and the property tests pass. If they do not return to step 1 and re-review.
