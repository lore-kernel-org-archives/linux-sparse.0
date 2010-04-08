From: Christopher Li <sparse@chrisli.org>
Subject: Re: L'\0' handling
Date: Thu, 8 Apr 2010 13:46:10 -0700
Message-ID: <g2p70318cbf1004081346t11dc0507u28f148c8b0706513@mail.gmail.com>
References: <1270738799.2167.7.camel@yura-tl> <4BBDF4C0.8020305@redhat.com>
	 <1270741172.2167.9.camel@yura-tl> <4BBDFC28.4080304@redhat.com>
	 <r2q70318cbf1004081319yc4bf61ccw252798cb98bc760b@mail.gmail.com>
	 <1270758815.2167.13.camel@yura-tl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:2153 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229Ab0DHUqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 16:46:11 -0400
Received: by qw-out-2122.google.com with SMTP id 8so952178qwh.37
        for <linux-sparse@vger.kernel.org>; Thu, 08 Apr 2010 13:46:11 -0700 (PDT)
In-Reply-To: <1270758815.2167.13.camel@yura-tl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Apr 8, 2010 at 1:33 PM, Yura Pakhuchiy <pakhuchiy@gmail.com> wr=
ote:
> Hi Chris,
>
> =D0=A3 =D0=A7=D1=86=D0=B2, 08/04/2010 =D1=83 13:19 -0700, Christopher=
 Li =D0=BF=D1=96=D1=88=D0=B0:
>> Yura, do you want to give this patch a try?
>
> Works great for me! Fixed all problems with wchar.h related includes.
> Thanks!

Great. Change pushed.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
