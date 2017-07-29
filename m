From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 12:30:16 -0400
Message-ID: <CANeU7Q=gAZ9hQ8AGNkhZ8d_=kL5i9QdPsS_980dq+WHsOVW-oQ@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com> <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36131 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbdG2QaR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:30:17 -0400
Received: by mail-pg0-f44.google.com with SMTP id 125so122462218pgi.3
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:30:17 -0700 (PDT)
In-Reply-To: <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 12:25 PM, Christopher Li <sparse@chrisli.org> wrote:
> No I don't think so. The find dominator already taking the cycles into
> account. By definition if X dominate Y, means every execution flow
> from entry point to Y will need to go through X. If X was not reachable,
> nor does Y. It does not change where the block get deleted. It just don't
> not need to do the marking algorithm. That is the point of dominator tree.

Hold on I think I make a mistake there. You are right. It only work if
we already know
that block is dead. If there is cycles that block has incoming edges. Let's
me think about it. There should be better way to detect that is back edge.

Thinking.

Chris
