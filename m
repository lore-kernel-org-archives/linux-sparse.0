From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Tue, 16 Feb 2010 11:36:21 -0800
Message-ID: <70318cbf1002161136o56cd0494pc6a2e38e28f1729c@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
	 <1266312482.3433.33.camel@thorin>
	 <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
	 <4B7AEFDF.3000608@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f178.google.com ([209.85.221.178]:45207 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994Ab0BPTgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Feb 2010 14:36:23 -0500
Received: by qyk8 with SMTP id 8so1309399qyk.24
        for <linux-sparse@vger.kernel.org>; Tue, 16 Feb 2010 11:36:21 -0800 (PST)
In-Reply-To: <4B7AEFDF.3000608@googlemail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>
Cc: linux-sparse@vger.kernel.org

2010/2/16 Jacek =C5=9Aliwerski <sliwers@googlemail.com>:
> So my question is: do you have any code that is not committed to
> git.kernel.org?

I see. II am using the chrisl branch under:
git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

The change you are missing is this:

http://git.kernel.org/?p=3Ddevel/sparse/chrisl/sparse.git;a=3Dcommit;h=3D=
9cdd3be634aab6fc98a17007d4db26fc050f213c

Sorry about that, I totally forget about it.

BTW, this should really flush into the official tree. Let me just do th=
at.

I am still sitting on the enum warning patch. That is the only thing ho=
lding
up another minor release.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
