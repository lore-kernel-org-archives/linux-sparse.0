From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Fri, 31 Mar 2017 10:55:00 +0200
Message-ID: <CAExDi1T4_0Jpi4vYmBr0B=SaG77tQLkeCpH-BbT0HbC+KFtz7w@mail.gmail.com>
References: <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com> <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com> <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
 <20170329144233.7hjyhshb72pbtv7s@macpro.local> <CANeU7QkuDjEeD=MvcLVz_DfAk5AsjRBqgCTcHnG5u1aHzEs-bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33469 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbdCaIzC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 04:55:02 -0400
Received: by mail-qk0-f169.google.com with SMTP id d201so31441184qkc.0
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 01:55:01 -0700 (PDT)
In-Reply-To: <CANeU7QkuDjEeD=MvcLVz_DfAk5AsjRBqgCTcHnG5u1aHzEs-bA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Fri, Mar 31, 2017 at 7:06 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Mar 29, 2017 at 10:42 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Dec 06, 2016 at 02:00:50PM +0800, Christopher Li wrote:
>>> The constant flags should be set regardless. Otherwise it is not consistent
>>> with the rest of the code.
>>
>> Chris, I don't really understand your remark here (regardless what ?).
>> Can you explain it a bit more please?
>
> In has been a while. The currently code only touch the result constexpr_flags if
> left and right are pointer and integer.  Otherwise, the
> constantexpr_flags are not
> touch at all. It is not obvious what is the previous state of the
> constantexpr_flags.
> I mean maybe it should clear it is that is not a constant? Most of the
> evaluate_xxx
> function will just set the new constexpr_flags.

The very first patch of the series insure that all flags are
initialized to the default 'NONE'. Then the next patches build
on this and add info/bits to flags case by case.

As far as I can see the patch was correct.

-- Luc
