From: Christopher Li <sparse@chrisli.org>
Subject: Re: suggestion for Merging LLVM
Date: Thu, 24 Nov 2011 17:45:15 -0800
Message-ID: <CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36423 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab1KYBpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Nov 2011 20:45:16 -0500
Received: by ggnr5 with SMTP id r5so3049529ggn.19
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2011 17:45:15 -0800 (PST)
In-Reply-To: <1321941674.1428.124.camel@jaguar>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 21, 2011 at 10:01 PM, Pekka Enberg <penberg@kernel.org> wro=
te:
> Agreed.
>
> I'd actually prefer that we keep the full history for one simple reas=
on:
> the commit changelogs. They provide valuable information on why we've
> implemented the things the way we have.

OK=EF=BC=8C I will just do the git merge then. Can you generate a pull =
request?

I just check out the sparse-llvm, the tip of the tree is broken for me:

     CC       sparse-llvm.o
sparse-llvm.c: In function =E2=80=98sym_struct_type=E2=80=99:
sparse-llvm.c:117:2: warning: implicit declaration of function
=E2=80=98LLVMStructCreateNamed=E2=80=99 [-Wimplicit-function-declaratio=
n]
sparse-llvm.c:117:6: warning: assignment makes pointer from integer
without a cast [enabled by default]
sparse-llvm.c:129:2: warning: implicit declaration of function
=E2=80=98LLVMStructSetBody=E2=80=99 [-Wimplicit-function-declaration]
     LINK     sparse-llvm
sparse-llvm.o: In function `sym_struct_type':
/export/git/sparse-llvm/sparse-llvm.c:117: undefined reference to
`LLVMStructCreateNamed'
/export/git/sparse-llvm/sparse-llvm.c:129: undefined reference to
`LLVMStructSetBody'
collect2: ld returned 1 exit status

I am using llvm 2.9, I guess my llvm is too new?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
