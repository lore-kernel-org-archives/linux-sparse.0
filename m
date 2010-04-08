From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: Re: L'\0' handling
Date: Thu, 08 Apr 2010 18:39:32 +0300
Message-ID: <1270741172.2167.9.camel@yura-tl>
References: <1270738799.2167.7.camel@yura-tl>  <4BBDF4C0.8020305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:34638 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756Ab0DHPjf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Apr 2010 11:39:35 -0400
Received: by bwz1 with SMTP id 1so1888877bwz.21
        for <linux-sparse@vger.kernel.org>; Thu, 08 Apr 2010 08:39:33 -0700 (PDT)
In-Reply-To: <4BBDF4C0.8020305@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: linux-sparse@vger.kernel.org

=D0=A3 =D0=A7=D1=86=D0=B2, 08/04/2010 =D1=83 17:22 +0200, Michael Stefa=
niuc =D0=BF=D1=96=D1=88=D0=B0:
> Yura Pakhuchiy wrote:
> > It looks like sparse do not understand constructions like L'\0'.
> yepp, it doesn't. I have run into that problem 2 years ago. But for W=
ine
> that is actually a "feature" as wide char/string literals are forbidd=
en
> aka cannot be used. Thus my interest in adding support for that in
> sparse died.

Wine is not the only project which uses sparse. Sparse is broken for an=
y
userspace program which includes wchar.h in Ubuntu with out supporting
this.

--=20
Best regards,
        Yura

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
