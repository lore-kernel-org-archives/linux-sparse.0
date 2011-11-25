From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 08:43:01 +0200
Message-ID: <CAOJsxLHyX9-v2JZcXp+otH+-54UJjURXY_XmG3ndEmXM56U=bw@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
	<CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
	<4ECEFC7E.5060905@garzik.org>
	<1322200349.1428.127.camel@jaguar>
	<CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56127 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab1KYGnC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 01:43:02 -0500
Received: by vcbfk14 with SMTP id fk14so1841023vcb.19
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2011 22:43:01 -0800 (PST)
In-Reply-To: <CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2011 at 9:52 PM, Pekka Enberg <penberg@kernel.org> wrot=
e:
>>> On 11/24/2011 08:45 PM, Christopher Li wrote:
>>> > I am using llvm 2.9, I guess my llvm is too new?
>>
>> On Thu, 2011-11-24 at 21:25 -0500, Jeff Garzik wrote:
>>> I would guess too-old. =A0I use a git checkout from the LLVM repo.
>>
>> We require LLVM 3.0 which hasn't been released because of this API:

On Fri, Nov 25, 2011 at 8:28 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> Hmm, how does older version of LLVM deal with structure refering them=
self?
>
> I hope there is a way so I can at least have an option to use the
> released version of LLVM. =A0I don't mind using LLVM 3.0 if it is the=
re,
> but requiring unreleased version of LLVM seems too bleeding edge.

I wasn't able to find out any C API for that and assume it was only
possible with the C++ API. That said, I'd also be happy to use
something else to be compatible with older versions if there is one.
Any LLVM experts on the list?

LLVM 3.0 is going to be released "real soon now" so I don't think it's
a problem in practice. We'd need to add a version check, though so we
don't break build on machines that have older LLVM installed.

                                 Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
