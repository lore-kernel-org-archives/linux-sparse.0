From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse documentation format, rST vs MD
Date: Mon, 7 Aug 2017 03:44:24 +0200
Message-ID: <CAExDi1SNSLSSSW8tj1rzOdSRUcSz57LLYMtkYDdtB2MnF47X3w@mail.gmail.com>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:38666 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdHGBoZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:44:25 -0400
Received: by mail-qk0-f172.google.com with SMTP id x191so32712764qka.5
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:44:25 -0700 (PDT)
In-Reply-To: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 3:28 AM, Christopher Li <sparse@chrisli.org> wrote:
> I want to use some mark down format for the document
> of sparse.
>
> There is two choice here:
>
> rST (reStructuredText)
> https://en.wikipedia.org/wiki/ReStructuredText
>
> MD (Mark Down)
> https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
>
> Does any one care which format to use?

Personally, I would stay with simple text files.
But as long as it is very readable as a text file I don't really care.

I often use the MediaWiki syntax when writing simple text because
I'm so used to it (it's what I have used for the instruction's doc) but
I would certainly not push for it.

MD is very fine for me.
The advantage that it's the format for github doesn't matter much
though since sparse is not hosted on github.

The real question to me is: do you intent to render it?

-- Luc
