From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 20:19:14 +0000
Message-ID: <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com> <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:33749 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdCPUTQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 16:19:16 -0400
Received: by mail-it0-f51.google.com with SMTP id w124so6820272itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 13:19:15 -0700 (PDT)
In-Reply-To: <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Linus,

On 16 March 2017 at 18:40, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, Mar 16, 2017 at 11:24 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Agreed and we are doing that except that the function call instruction
>> only has the type of the call, not the arguments (as far as I
>> understand - apologies if I have got this wrong).
>
> The "OP_CALL" should have the call type in the instruction itself:
>
>                 struct /* call */ {
>                         pseudo_t func;
>                         struct pseudo_list *arguments;
>                         struct symbol *fntype;
>                 };
>
> in that "fntype".
>
> So you should not need it for the pseudo (that contains the address of
> the function to call).
>

Yes, the function type is available, and this is used.

> In particular, it's not uncommon to have auto-generated code (or
> various handwritten interpreters) have the function be encoded as some
> kind of void pointer, and then depending on use, the same pointer
> value is used differently.
>
> Eg code like this:
>
>     typedef int (*binop_t)(int, int);
>     typedef int (*unop_t)(int);
>
>     #define BINOP 0
>
>     unsigned int execute(int type, void *fn, int arg1, int arg2)
>     {
>         if (type == BINOP)
>                 return ((binop_t)fn)(arg1,arg2);
>         return ((unop_t)fn)(arg1);
>     }
>
> which will linearize to something that does:
>
>     call.32     %r7 <- %r6, %arg3, %arg4
>
> in one branch, and
>
>     call.32     %r13 <- %r6, %arg3
>
> in another. Notice how it uses the same pseudo (%r6) in both cases,
> even though the type of the function called is different.
>

The issue is not with the type of %r6 but %arg3 and %arg4 if these
happen to be integer constants, and the function is variadic so we
cannot work out the type from the function prototype.

Here is a contrived example:

extern void concat(char *buf, unsigned long long len, ...);
#define NULL ((void *)0)
int main(void)
{
 char temp[256];
 concat(temp, sizeof temp, "hello", "world", NULL);
 return 0;
}

The linearized output is:

main:
.L0:
        <entry-point>
        symaddr.64  %r1 <- temp
        symaddr.64  %r2 <- <anon symbol:0000029439DF4E18>
        symaddr.64  %r3 <- <anon symbol:0000029439DF5198>
        call        concat, %r1, $256, %r2, %r3, $0
        ret.32      $0

The last argument $0 is a PSEUDO_VAL. The issue is working out what
should be the type/size of this constant.

I hope this is clearer in explaining what the problem is.

Btw the example you gave failed in sparse-llvm - because there is no
explicit cast in the linearized output. To fix it we basically have to
always cast a function to its expected type.

Thanks and Regards
Dibyendu
