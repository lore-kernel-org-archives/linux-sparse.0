From: Christopher Li <sparse@chrisli.org>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 12:20:53 -0400
Message-ID: <CANeU7Qmo8j9EhP5HQ6=0Gd5HVGd7JYQqfp+yhRBE2E7K7zdL0g@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local> <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33638 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQUz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:20:55 -0400
Received: by mail-yw0-f180.google.com with SMTP id h127so12051778ywf.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:20:54 -0700 (PDT)
In-Reply-To: <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 12:12 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Okay the linear output above seems SSA if we consider how it is shown
> in the output. But in the code, access to 0[a] occurs via a pseudo -
> of type PSEUDO_SYM. We see multiple stores happening to this pseudo.
> So the question is each access generated through a different instance
> of a pseudo? I see that in the code if a symbol already has a pseudo

After promote the memory into pseudo, yes. each store is consider
a new "define" from the SSA point of  view. So it is a new pseudo,
or new number of the variable in some SSA book.

> then it is reused. So presumably then PSEUDO_SYMs are not SSA, but
> PSEUDO_REGs are?

PSEUDO_SYMS are static, you can think them as symbol address.
It never change. There for it does not need phi node to qualify as SSA.


> So then is it more accurate to say that PSEUDO_SYM and possibly
> PSEUDO_ARG too - represent memory access, and are just a proxy for
> stack allocated memory?

I am not sure I understand you. PSEUDO_SYM is the address of the symbol.
Load/Store is using this address to perform memory access.
After convert the memory content into pseudo, that new pseudo represent
the memory storage need to be SSA.

PSEUDO_ARG is just a pseudo receiving the function call arguments.
It will not change either. Any time some one assign a value to the arguments,
it will generate new instance of the pseudo.

Spare IR does not care if the argument is passing from stack or not.

Chris
