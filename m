From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 11:36:29 -0700
Message-ID: <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com> <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35575 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbdHOSga (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 14:36:30 -0400
Received: by mail-oi0-f53.google.com with SMTP id e124so15281271oig.2
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 11:36:30 -0700 (PDT)
In-Reply-To: <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 7:09 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> https://github.com/lucvoo/sparse/tree/sssa-mini-clean

I like it. But the commit messages are sorely lacking. And I'm not
talking just about the lack of sign-off's, I'm talking about the
messages just not explaining what is going on AT ALL.

But with that fixed, I heartily recommend merging the new ssa
construction code. It's based on a real paper, rather than being
ad-hoc.

                 Linus
