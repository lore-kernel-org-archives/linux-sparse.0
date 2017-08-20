From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 09:33:49 -0700
Message-ID: <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local> <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
 <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com> <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33395 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbdHTQdu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:33:50 -0400
Received: by mail-oi0-f51.google.com with SMTP id f11so135219965oic.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:33:50 -0700 (PDT)
In-Reply-To: <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 9:26 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>
>> No. All pseudos are strictly write-once (after the SSA conversion).
>> Memory operations don't write to pseudos. They only use pseudos for
>> addresses.
>
> Thanks. So does that mean that pseudos are SSA from the initial
> linearization phase, and therefore the baseline linear output is
> already SSA? By SSA conversion are you referring to the subsequent
> phase when memory accesses are converted to pseudos where possible?

I wouldn't guarantee it - I *think* it may be the case that even the
initial linearization is actually proper SSA (just with everything
going through memory), but I don't think it's necessarily a real
design choice. We do have a "non-SSA" mode that turns phi sources into
OP_COPY that is very much not SSA.

So our linearization form does support a non-SSA mode, although
honestly, I'm not sure how useful it is.

Luc knows this code much better than me by now.

                  Linus
