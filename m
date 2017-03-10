From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Fri, 10 Mar 2017 16:08:48 +0000
Message-ID: <CACXZuxdyT9LWejONpYi0rg7hr+xoVgdS-Wy_6OhSps_RL8idZw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-7-luc.vanoostenryck@gmail.com> <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
 <CACXZuxeTUqXuBd+42SGFB5sLDirea1q2WnG8s=SqcU+DAd1-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35615 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdCJQIu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Mar 2017 11:08:50 -0500
Received: by mail-io0-f181.google.com with SMTP id z13so51437573iof.2
        for <linux-sparse@vger.kernel.org>; Fri, 10 Mar 2017 08:08:49 -0800 (PST)
In-Reply-To: <CACXZuxeTUqXuBd+42SGFB5sLDirea1q2WnG8s=SqcU+DAd1-3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 March 2017 at 19:41, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 7 March 2017 at 15:33, Christopher Li <sparse@chrisli.org> wrote:
>> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> Like for all others instructions, LLVM needs the type
>>> of each operands. However this information is not always
>>> available via the pseudo, like here when passing a integer
>>> constant as argument since for sparse constants are typeless.
>>>
>>> Fix this by getting the type via the function prototype.
>>>
>>> +               LLVMValueRef value;
>>> +               if (arg->type == PSEUDO_VAL) {
>>> +                       /* Value pseudos do not have type information. */
>>> +                       /* Use the function prototype to get the type. */
>>> +                       struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);
>>
>> I try to come up with an example to use the PREPARE_PTR_LIST() in this patch.
>
> I suppose that the function prototype may not have the same number of
> declared parameters as the actual call arguments - e.g. if the
> function is variadic. In that case there may not be corresponding
> parameter definition available. I think that in this case default
> argument promotion rules will need to be applied for trailing
> arguments.
>

I have also hit a problem when calling a function via function
pointer. In this case the instruction->func appears to be PSEUDO_REG
rather than PSEUDO_SYM, so trying to get the function prototype
doesn't work.

If the call is a via a function pointer then where should one look for
what the argument type should be when a constant is encountered?

Regards
Dibyendu
