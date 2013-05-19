From: Pekka Enberg <penberg@kernel.org>
Subject: Re: Fwd: [problem] sparse llvm loop conditions
Date: Sun, 19 May 2013 11:16:23 +0300
Message-ID: <CAOJsxLGJRWHsL9u0YY3exzUm81Wgtef8gjWd6j=RZgzAj7Ts9w@mail.gmail.com>
References: <CAOJsxLF351XvYE6Av3hxMsqXeu2nT4vRjbLgwNAguNLEfgLQvQ@mail.gmail.com>
	<50312093.5050207@pobox.com>
	<20130518184203.GE3154@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38839 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab3ESIQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 04:16:24 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so1398951wgh.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 01:16:23 -0700 (PDT)
In-Reply-To: <20130518184203.GE3154@debian.debian>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Xi Wang <xi.wang@gmail.com>

On Sat, May 18, 2013 at 9:42 PM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> Hi Jeff, Pekka,
>
> On Sun, Aug 19, 2012 at 01:21:23PM -0400, Jeff Garzik wrote:
>> Here is a testcase that should get into the mailing list archives...
>>
>>       Jeff
>>
>> -------- Original Message --------
>> Subject: [problem] sparse llvm loop conditions
>> Date: Wed, 23 Nov 2011 08:56:25 +0200
>> From: Pekka Enberg <penberg@kernel.org>
>> To: Jeff Garzik <jeff@garzik.org>
>>
>> Hi Jeff,
>>
>> Have you seen this already?
>>
>> [penberg@tux sparse]$ cat loop.c
>> struct list_node {
>>       struct list_node *next;
>> };
>>
>> int foo(struct list_node *node)
>> {
>>       int ret =3D 0;
>>       while (node) {
>>               node =3D node->next;
>>               ret++;
>>       }
>>       return ret;
>> }
>> [penberg@tux sparse]$ ./sparse-llvm loop.c
>> loop.c:5:5: warning: symbol 'foo' was not declared. Should it be sta=
tic?
>> sparse-llvm: Instructions.cpp:730: void llvm::BranchInst::AssertOK()=
:
>> Assertion `getCondition()->getType()->isIntegerTy(1) && "May only
>> branch on boolean predicates!"' failed.
>> Aborted
>
> With my patchset of today, sparse-llvm compiles this code. It turned =
out
> that struct accesses didn't work, because the address computed for
> load/store instructions didn't have the right LLVM type.

Indeed it does! :-)

Just in case people want to try it out, the code is in my llvm/core bra=
nch here:

https://github.com/penberg/sparse-llvm/tree/llvm/core

                         Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
