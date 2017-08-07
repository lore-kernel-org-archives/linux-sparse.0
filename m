From: Pavel Roskin <plroskin@gmail.com>
Subject: Re: Sparse documentation format, rST vs MD
Date: Sun, 6 Aug 2017 23:03:14 -0700
Message-ID: <CAN_72e2UF1TLWO_tGUyC2idjNegn9=um7_1fZNBVWxuR0Kr+Xg@mail.gmail.com>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36856 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdHGGDQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 02:03:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id b130so6733640oii.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 23:03:15 -0700 (PDT)
In-Reply-To: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hello!

On Sun, Aug 6, 2017 at 6:28 PM, Christopher Li <sparse@chrisli.org> wrote:
> I want to use some mark down format for the document
> of sparse.

It would be great to have more sparse documentation!

> There is two choice here:
>
> rST (reStructuredText)
> https://en.wikipedia.org/wiki/ReStructuredText
>
> MD (Mark Down)
> https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
>
> Does any one care which format to use?
>
> So far I am weak leaning towards MD but I can be convenience
> otherwise. Mostly because MD render on github is very nicely.
> I already use MD on other projects.
>
> Here is my run down of Pros and Cons
> rST Pros:
>
> -  Linux kernel already using rST for documents like
>    submiting-patches.rst. I need a file for sparse version of
>    submitting-patches.
>
> - might be more friendly to code syntax. But I am not going to use
>   those really deep extensions any way.
>
> rST Cons (for me):
> - I don't know rST at all. I need to learn it.
> - github does not recognized rST naturally.

Not true for that point:
https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst

> MarkDown Pros:
> - More friendly to web.

What does it mean exactly? Both should be convertable to HTML.

> - Github etc can render .md properly on display.
> - I already know how the syntax. No need to learn.
>
> MarkdDown Cons:
> - Kernel is using rST. I need to convert the format if I borrow
>   some file from the Linux Kernel.

I would say go with rST unless the major potential contributors insist
on Markdown. Capturing the knowledge is more important than selecting
the format. The format can be changed if a "wrong" choice is made.

Pavel
