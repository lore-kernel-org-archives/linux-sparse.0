From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Fri, 31 Mar 2017 18:40:26 +0800
Message-ID: <CANeU7QmsZ1rd_P3O45FuZ1y3tO8fOAOgp-+iqiJs400cQOCWsg@mail.gmail.com>
References: <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com> <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com> <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
 <20170329144233.7hjyhshb72pbtv7s@macpro.local> <CANeU7QkuDjEeD=MvcLVz_DfAk5AsjRBqgCTcHnG5u1aHzEs-bA@mail.gmail.com>
 <CAExDi1T4_0Jpi4vYmBr0B=SaG77tQLkeCpH-BbT0HbC+KFtz7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36175 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932619AbdCaKk2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 06:40:28 -0400
Received: by mail-it0-f46.google.com with SMTP id e75so10282497itd.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 03:40:27 -0700 (PDT)
In-Reply-To: <CAExDi1T4_0Jpi4vYmBr0B=SaG77tQLkeCpH-BbT0HbC+KFtz7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Fri, Mar 31, 2017 at 4:55 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The very first patch of the series insure that all flags are
> initialized to the default 'NONE'. Then the next patches build
> on this and add info/bits to flags case by case.
>
> As far as I can see the patch was correct.

How about a different test case. The right hand side is a const
expression but not an int const expression.
So the result is not an address constant.  The result should be some
other kind of constant since both
left hand side and right hand side are both constant expression. If
the result has NONE then it is wrong.

Chris
