From: Christopher Li <sparse@chrisli.org>
Subject: Sparse documentation format, rST vs MD
Date: Sun, 6 Aug 2017 21:28:58 -0400
Message-ID: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:37605 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGB3A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:29:00 -0400
Received: by mail-pg0-f46.google.com with SMTP id y129so27740006pgy.4
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:28:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I want to use some mark down format for the document
of sparse.

There is two choice here:

rST (reStructuredText)
https://en.wikipedia.org/wiki/ReStructuredText

MD (Mark Down)
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

Does any one care which format to use?

So far I am weak leaning towards MD but I can be convenience
otherwise. Mostly because MD render on github is very nicely.
I already use MD on other projects.

Here is my run down of Pros and Cons
rST Pros:

-  Linux kernel already using rST for documents like
   submiting-patches.rst. I need a file for sparse version of
   submitting-patches.

- might be more friendly to code syntax. But I am not going to use
  those really deep extensions any way.

rST Cons (for me):
- I don't know rST at all. I need to learn it.
- github does not recognized rST naturally.


MarkDown Pros:
- More friendly to web.
- Github etc can render .md properly on display.
- I already know how the syntax. No need to learn.

MarkdDown Cons:
- Kernel is using rST. I need to convert the format if I borrow
  some file from the Linux Kernel.

Feed back?

Chris
