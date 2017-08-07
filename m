From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse documentation format, rST vs MD
Date: Sun, 6 Aug 2017 21:58:55 -0400
Message-ID: <CANeU7QmQuF22A2U2+fqAa4kydqRcGD9Wj3QjTtx2kNC2kBWr6A@mail.gmail.com>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
 <CAExDi1SNSLSSSW8tj1rzOdSRUcSz57LLYMtkYDdtB2MnF47X3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36557 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdHGB64 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:58:56 -0400
Received: by mail-pg0-f50.google.com with SMTP id v77so27953319pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:58:56 -0700 (PDT)
In-Reply-To: <CAExDi1SNSLSSSW8tj1rzOdSRUcSz57LLYMtkYDdtB2MnF47X3w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 9:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Personally, I would stay with simple text files.
> But as long as it is very readable as a text file I don't really care.

Both are close enough to text file and some what readable
as the raw form. I think md is slightly easier to read in raw form
than rST but I might be biased because I know MD already.

> I often use the MediaWiki syntax when writing simple text because
> I'm so used to it (it's what I have used for the instruction's doc) but
> I would certainly not push for it.
>
> MD is very fine for me.
> The advantage that it's the format for github doesn't matter much
> though since sparse is not hosted on github.

I am thinking if we want to invite other developers. It is more
likely for them to host on github than kernel.org. We can also keep a
github mirror of sparse. I have one but I haven't update it for a while.

> The real question to me is: do you intent to render it?

Oh, I often do. I have makefile that render md as pdf and html.
It is easier to pass around that way for people only need to read
it.

I also use the chrome plugin to view MD directly as the render
result. Things like tables in MD can translate to html tables which is
very nice.

I assume rST can do html table and render as pdf/html as well.

Chris
