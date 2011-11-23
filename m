From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Wed, 23 Nov 2011 08:58:12 +0200
Message-ID: <CAOJsxLFc6Qq3ThiX6AOJ6GmnSUSJP5Ft-ySUXk3KGSdfHNZuEw@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
	<4ECC06F7.8040006@garzik.org>
	<CAOJsxLGqsH9vbE9AQO2chV28Wx=iw5hA9dJzR3X1Cvrd5Sv6Eg@mail.gmail.com>
	<4ECC8C23.4080909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40285 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758600Ab1KWG6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 Nov 2011 01:58:12 -0500
Received: by vcbfk1 with SMTP id fk1so1034292vcb.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 22:58:12 -0800 (PST)
In-Reply-To: <4ECC8C23.4080909@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 23, 2011 at 8:01 AM, Jeff Garzik <jeff@garzik.org> wrote:
> On 11/22/2011 03:38 PM, Pekka Enberg wrote:
>>
>> So pasting the above test program tohttp://llvm.org/demo/ =A0and
>> switching to "LLVM C++ API code" target seems to suggest you're
>> interested in the LLVMReplaceAllUsesWith() API for forward reference=
s.
>
> Sent pull req via github.
>
> List implementation is cheesy (inefficient if list ever gets woefully=
 large)
> singly-linked list, but it is pretty simple. =A0Turned out that postp=
oning
> LLVMAddIncoming() call works better than LLVMReplaceAllUsesWith() API=
:
>
>
> (warning: do not apply directly, patch is unfortunately word-wrapped;=
 see
> pull request)

Pulled, thanks!

P.S. Could you please put your test cases under validation/backend?
It's really easy to make them part of regular "make check".
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
