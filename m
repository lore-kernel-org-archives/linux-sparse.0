From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Tue, 16 Oct 2012 20:59:27 +0300
Message-ID: <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
	<CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
	<20121010163306.GA2846@debian.debian>
	<CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54326 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab2JPR72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Oct 2012 13:59:28 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so178688wib.1
        for <linux-sparse@vger.kernel.org>; Tue, 16 Oct 2012 10:59:27 -0700 (PDT)
In-Reply-To: <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Oct 12, 2012 at 9:25 PM, Pekka Enberg <penberg@kernel.org> wrot=
e:
> On Wed, Oct 10, 2012 at 7:33 PM, Jonathan Neusch=E4fer
> <j.neuschaefer@gmx.net> wrote:
>> I can't say with certainty that it's safe either, so I probably shou=
ld
>> have marked the patch with "request for comments".
>>
>> AFAICT there are three reasons an instruction cannot be moved up or =
down
>> within a basic block:
>>  1. If it takes previous SSA values as arguments, it can't be moved
>>     above the corresponding intructions.
>>  2. If its value is used as an argument of an instruction further do=
wn
>>     in the BB, it can't be moved below that instruction.
>>  3. Swapping two instructions that influence or are influenced by th=
e
>>     "global state" (sorry for the loose wording), e.g. by doing memo=
ry
>>     accesses, performing I/O, or calling functions (which in turn ca=
n
>>     do about anything in general), is generally unsafe.
>>
>> Case 1 doesn't apply because PHI nodes don't use values computed in =
the
>> same invocation of their basic block. Case 2 doesn't apply as I'm no=
t
>> moving the PHI nodes down. Case 3 doesn't seem to apply either.
>>
>> That's how I think this patch is safe.
>
> Sounds plausible but I'm still uneasy with the idea that LLVM backend
> needs to reshuffle instructions like this.
>
> Would it be possible to solve this in the frontend?

Linus, Chris, any thoughts on this?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
