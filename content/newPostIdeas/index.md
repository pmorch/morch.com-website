---
author: Peter
draft: true
title: NewPostIdeas
type: post
# categories:
# - Spirituality
# - Technology
menu: main
toc: true
---

## HTTPS Proxy
## Keycloak Forceuser?

## Docker Security

Passwords stored in .dotfiles?

## Usability of Streaming

Split streaming into the content and the GUI. But the money is
in the GUI.

## Avoiding Git Merge Conflicts

You are working on a branch and sooner or later, you need to merge with a main branch. And then you experience the nasty

```bash
merge conflict
```

This post is about one of the most common causes for merge conflicts: When lines are added to the bottom of a section of a file in both branches.

 any language, but I provide a java example

You know the situation: 

Supporting links:

* [LAPI](https://gitlab.lessor.dk/LAPI/api-core/-/blob/master/api-core/src/main/java/dk/lessor/api/core/servicelocator/ServiceLocatorImpl.java)
* [ServiceLoader (Java Platform SE 7 )](https://docs.oracle.com/javase/7/docs/api/java/util/ServiceLoader.html)
* [java - META-INF/services in JAR with Gradle - Stack Overflow](https://stackoverflow.com/questions/13254620/meta-inf-services-in-jar-with-gradle)

## Installing a script with `brew` by creating a Formula

Say we have a tiny script that we want to distribute with `brew`.

We create a tarball with the script and create a formula file with a formula in
it. It references the newly created tarball and its `sha256sum`.

Discovering the name of the class (in "CamelCase") from the formula name (in
"kebab-case") is somewhat straight-forward, but alas, is a [private
method](https://rubydoc.brew.sh/Formulary.html#class_s-class_method). But not
likely to change, honestly...
