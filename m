From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse documentation format, rST vs MD
Date: Mon, 7 Aug 2017 07:29:58 -0400
Message-ID: <CANeU7Qk-BVrqh_S50=oC7MhaNPsDgYa8AZr9v1VXoSmeVsNUMQ@mail.gmail.com>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
 <CAN_72e2UF1TLWO_tGUyC2idjNegn9=um7_1fZNBVWxuR0Kr+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36029 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbdHGL37 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 07:29:59 -0400
Received: by mail-pg0-f46.google.com with SMTP id v77so619482pgb.3
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 04:29:59 -0700 (PDT)
In-Reply-To: <CAN_72e2UF1TLWO_tGUyC2idjNegn9=um7_1fZNBVWxuR0Kr+Xg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <plroskin@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Mon, Aug 7, 2017 at 2:03 AM, Pavel Roskin <plroskin@gmail.com> wrote:
> Hello!
>
> On Sun, Aug 6, 2017 at 6:28 PM, Christopher Li <sparse@chrisli.org> wrote:
>> I want to use some mark down format for the document
>> of sparse.
>
> It would be great to have more sparse documentation!

OK, if you have more wish list what area of sparse you want to
have. I can add that to my illusion list of sparse projects.


>> rST Cons (for me):
>> - I don't know rST at all. I need to learn it.
>> - github does not recognized rST naturally.
>
> Not true for that point:
> https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst

Oh, I did not know that. Thanks for pointing it out.

>
>> MarkDown Pros:
>> - More friendly to web.
>
> What does it mean exactly? Both should be convertable to HTML.


Mark Down can embed html tags easier. If you only care about using
Mark Down in the web, you can do some thing like this:

Disclaimer: I haven't try it myself though, I believe every thing I read
on the internet :-)

# Heading 1

<div class="something" markdown="1">
  ## Heading 2
  Some **bold** text.
</div>


> I would say go with rST unless the major potential contributors insist
> on Markdown. Capturing the knowledge is more important than selecting
> the format. The format can be changed if a "wrong" choice is made.

So far we have 2 on MD (Josh strongly).
You are on reStructuredText.

I just did a google trends comparing keyword "Markdown" and "reStructuredText"
It seems "Markdown" is overwhelming more popular then "reStructuredText".

If I try "RST" then "RST" is slightly ahead of "Markdown", but mostly
due to false positives. Google "RST" most result are not "reStructuredText"
related.

I think I will go with MarkDown for now. You are right the content is the
most important, not the format.

Chris
