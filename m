From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 22:37:38 +0200
Message-ID: <CAExDi1TyYBvO8zvYfc9hua1CkAQqtbA1SAtxZuPLtxZKkk=Y_A@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com> <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35848 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdHOUhj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 16:37:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id b130so1798963oii.3
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 13:37:39 -0700 (PDT)
In-Reply-To: <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 8:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I like it. But the commit messages are sorely lacking. And I'm not
> talking just about the lack of sign-off's, I'm talking about the
> messages just not explaining what is going on AT ALL.

My 'real' patches are much more 'down-broken' (is that a word?)
but you need to have the whole to not have regressions in the
testsuite. So, in this ssa-mini[-clean], I just squashed a lot of
commits together.

I'm not really sure what can be done in this case (albeit all my
love for small, incremental changes).

-- Luc
