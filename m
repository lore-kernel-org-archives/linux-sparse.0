From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 10:29:51 +0200
Message-ID: <CAOJsxLEp0j2xinKPRecDF6fB3cBq0NuVg7btb_VMECEptqQtgA@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
	<CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
	<4ECEFC7E.5060905@garzik.org>
	<1322200349.1428.127.camel@jaguar>
	<CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com>
	<CAOJsxLHyX9-v2JZcXp+otH+-54UJjURXY_XmG3ndEmXM56U=bw@mail.gmail.com>
	<CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53579 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab1KYI3w (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 03:29:52 -0500
Received: by vcbfk14 with SMTP id fk14so1885457vcb.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 00:29:51 -0800 (PST)
In-Reply-To: <CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On Thu, Nov 24, 2011 at 10:43 PM, Pekka Enberg <penberg@kernel.org> wrote:
>> I wasn't able to find out any C API for that and assume it was only
>> possible with the C++ API. That said, I'd also be happy to use
>> something else to be compatible with older versions if there is one.
>> Any LLVM experts on the list?

On Fri, Nov 25, 2011 at 10:05 AM, Christopher Li <sparse@chrisli.org> wrote:
> If it just need to use the C++ API, we can compile a bridge c++ file
> to export the missing C++ API to C file. It is actually pretty common praticse
> if you play with LLVM internal a lot, some API just don't exist in C yet.
> We are already using g++ to link llvm, one more c++ file could not hurt.
> If we need some C++ only API later, we can add it there as well.
>
> What do you say?

Well, sure, that would be the perfect solution.

Unfortunately, I'm not at all familiar with the C++ API. I did look at
just adding the LLVM 3.0 LLVMStructCreateNamed() and
LLVMStructSetBody() wrappers on top of LLVM 2.8 but they don't compile
because StructType API changed. So it's not going to be as simple as
copy-pasting the missing functions to sparse.git.

On Thu, Nov 24, 2011 at 10:43 PM, Pekka Enberg <penberg@kernel.org> wrote:
>> LLVM 3.0 is going to be released "real soon now" so I don't think it's
>> a problem in practice. We'd need to add a version check, though so we
>> don't break build on machines that have older LLVM installed.

On Fri, Nov 25, 2011 at 10:05 AM, Christopher Li <sparse@chrisli.org> wrote:
> Still, it will take a while for the distribution to update to the new version.

Sure.

Do you consider this to be a merge blocker? I'd personally just go
forward with LLVM 3.0 and add the compat wrappers along the way if
there are people who actually care about it.

                                Pekka
