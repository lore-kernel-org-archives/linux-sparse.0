From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-llvm test cases
Date: Thu, 10 Aug 2017 19:55:52 -0400
Message-ID: <CANeU7QkuzQ8ZJFS7ikpnq60hp85tPeGMdtbvSY21+7Mdtgez4Q@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
 <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com> <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35812 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdHJXzx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 19:55:53 -0400
Received: by mail-yw0-f181.google.com with SMTP id l82so13970716ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 16:55:52 -0700 (PDT)
In-Reply-To: <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 6:50 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> One thing I want to have for testing linearized code is a simulator
> for sparse's IR. It's even something quite easy (or at least straightforward)
> to do. At least once you can associate to each phi-node's 'argument' the
> parent BB they come from. This is something I'm planning to do for several
> reasons.

BTW, I have some python script that parse the show_entry() output.
It is not complete but it is easy enough to extend.  I use the script
to capture some part of the IR for prototyping compiler related algorithms.
e.g. simple fast way to find dominators. Python has very nice pretty printer
and very easy to write verification test. e.g. the dominator I found really
is a dominator.  For complex algorithms, I like to verify it works correctly in
scripts before coding in C.

Chris
