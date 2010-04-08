From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: L'\0' handling
Date: Thu, 08 Apr 2010 22:58:16 +0200
Message-ID: <4BBE4368.4080105@redhat.com>
References: <1270738799.2167.7.camel@yura-tl> <4BBDF4C0.8020305@redhat.com>	 <1270741172.2167.9.camel@yura-tl> <4BBDFC28.4080304@redhat.com>	 <r2q70318cbf1004081319yc4bf61ccw252798cb98bc760b@mail.gmail.com>	 <1270758815.2167.13.camel@yura-tl> <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758869Ab0DHU65 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 16:58:57 -0400
In-Reply-To: <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hello Chris,

On 04/08/2010 10:46 PM, Christopher Li wrote:
> On Thu, Apr 8, 2010 at 1:33 PM, Yura Pakhuchiy<pakhuchiy@gmail.com>  =
wrote:
>> Hi Chris,
>>
>> =D0=A3 =D0=A7=D1=86=D0=B2, 08/04/2010 =D1=83 13:19 -0700, Christophe=
r Li =D0=BF=D1=96=D1=88=D0=B0:
>>> Yura, do you want to give this patch a try?
>>
>> Works great for me! Fixed all problems with wchar.h related includes=
=2E
>> Thanks!
>
> Great. Change pushed.
I have looked at the patch but I don't see it handle wchar_t string=20
literals like L"Hello World\n".

bye
	michael
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
