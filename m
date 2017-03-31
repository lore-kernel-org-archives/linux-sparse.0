From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Fri, 31 Mar 2017 21:47:17 +0200
Message-ID: <CAExDi1SQ1gHF10xkJWhPfmSyAt03_d-jk3Eyjk3ofZ3K73zrNA@mail.gmail.com>
References: <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com> <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com> <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
 <20170329144233.7hjyhshb72pbtv7s@macpro.local> <CANeU7QkuDjEeD=MvcLVz_DfAk5AsjRBqgCTcHnG5u1aHzEs-bA@mail.gmail.com>
 <CAExDi1T4_0Jpi4vYmBr0B=SaG77tQLkeCpH-BbT0HbC+KFtz7w@mail.gmail.com> <CANeU7QmsZ1rd_P3O45FuZ1y3tO8fOAOgp-+iqiJs400cQOCWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35698 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdCaTrS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 15:47:18 -0400
Received: by mail-qk0-f174.google.com with SMTP id g195so3511941qke.2
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 12:47:19 -0700 (PDT)
In-Reply-To: <CANeU7QmsZ1rd_P3O45FuZ1y3tO8fOAOgp-+iqiJs400cQOCWsg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Fri, Mar 31, 2017 at 12:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Mar 31, 2017 at 4:55 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The very first patch of the series insure that all flags are
>> initialized to the default 'NONE'. Then the next patches build
>> on this and add info/bits to flags case by case.
>>
>> As far as I can see the patch was correct.
>
> How about a different test case. The right hand side is a const
> expression but not an int const expression.
> So the result is not an address constant.  The result should be some
> other kind of constant since both
> left hand side and right hand side are both constant expression. If
> the result has NONE then it is wrong.

OK, I think I begin to understand.
It's important that the standard is not coherent on the notion of
constant vs. constant expression.
This distinction exists for integers:
- a case in a switch statement requires an integer constant
- initializers are happy with integer constant expressions.
For address, no such distinction exists, the standard specifically
states in [6.6.9]:
    An address constant is a null pointer, a pointer to an lvalue
    designating an object of static storage duration, or a pointer
    to a function designator; it shall be created explicitly using
    the unary & operator or an integer constant cast to pointer type,
    or implicitly by the use of an expression of array or function type.
    The array-subscript [] and member-access . and -> operators,
    the address & and indirection * unary operators, and pointer casts
    may be used in the creation of an address constant, but the value
    of an object shall not be accessed by use of these operators.

If the LHS is not an address constant, the result will not be any kind
of constexprs. And if the LHS is an address constant but the RHS is
not an integer constant expression then the result will also not be any
kind of constexprs. Which leave us with the case covered here.
Am I missing something?

-- Luc
