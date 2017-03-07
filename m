From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Tue, 7 Mar 2017 19:41:39 +0000
Message-ID: <CACXZuxeTUqXuBd+42SGFB5sLDirea1q2WnG8s=SqcU+DAd1-3Q@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-7-luc.vanoostenryck@gmail.com> <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36127 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756091AbdCGTmG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 14:42:06 -0500
Received: by mail-it0-f51.google.com with SMTP id h10so77806855ith.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 11:41:40 -0800 (PST)
In-Reply-To: <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 7 March 2017 at 15:33, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Like for all others instructions, LLVM needs the type
>> of each operands. However this information is not always
>> available via the pseudo, like here when passing a integer
>> constant as argument since for sparse constants are typeless.
>>
>> Fix this by getting the type via the function prototype.
>>
>> +               LLVMValueRef value;
>> +               if (arg->type == PSEUDO_VAL) {
>> +                       /* Value pseudos do not have type information. */
>> +                       /* Use the function prototype to get the type. */
>> +                       struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);
>
> I try to come up with an example to use the PREPARE_PTR_LIST() in this patch.

I suppose that the function prototype may not have the same number of
declared parameters as the actual call arguments - e.g. if the
function is variadic. In that case there may not be corresponding
parameter definition available. I think that in this case default
argument promotion rules will need to be applied for trailing
arguments.

Regards
Dibyendu
