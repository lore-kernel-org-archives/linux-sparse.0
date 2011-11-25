From: Christopher Li <sparse@chrisli.org>
Subject: Re: suggestion for Merging LLVM
Date: Thu, 24 Nov 2011 22:28:17 -0800
Message-ID: <CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
	<CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
	<4ECEFC7E.5060905@garzik.org>
	<1322200349.1428.127.camel@jaguar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37277 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1KYG2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 01:28:19 -0500
Received: by ghrr1 with SMTP id r1so3137270ghr.19
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2011 22:28:18 -0800 (PST)
In-Reply-To: <1322200349.1428.127.camel@jaguar>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2011 at 9:52 PM, Pekka Enberg <penberg@kernel.org> wrot=
e:
>> On 11/24/2011 08:45 PM, Christopher Li wrote:
>> > I am using llvm 2.9, I guess my llvm is too new?
>
> On Thu, 2011-11-24 at 21:25 -0500, Jeff Garzik wrote:
>> I would guess too-old. =A0I use a git checkout from the LLVM repo.
>
> We require LLVM 3.0 which hasn't been released because of this API:

Hmm, how does older version of LLVM deal with structure refering themse=
lf?

I hope there is a way so I can at least have an option to use the
released version of LLVM.  I don't mind using LLVM 3.0 if it is there,
but requiring unreleased version of LLVM seems too bleeding edge.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
