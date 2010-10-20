From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Wed, 20 Oct 2010 08:34:59 -0700
Message-ID: <AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<1286710919.24953.2.camel@thorin>
	<201010101352.10864.kdudka@redhat.com>
	<1286790249.24953.14.camel@thorin>
	<AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	<20101011191219.GD8537@feather>
	<1286981110.14103.86.camel@thorin>
	<20101020072945.GA3232@ZenIV.linux.org.uk>
	<1287567544.7542.7.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63327 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab0JTPfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Oct 2010 11:35:04 -0400
Received: by gxk21 with SMTP id 21so1640971gxk.19
        for <linux-sparse@vger.kernel.org>; Wed, 20 Oct 2010 08:35:01 -0700 (PDT)
In-Reply-To: <1287567544.7542.7.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

On Wed, Oct 20, 2010 at 2:39 AM, Bernd Petrovitsch <bernd@sysprog.at> w=
rote:
>> certainly reek of IOCCC. =A0I'd rather avoid "if_true" as replacemen=
t, though.
>> If anything, true_expr and false_expr would make more sense.
>
> I have no strong feelings about the replacement and just followed the
> change in the referenced commit.
> Chris, should I respin the patch with *_expr?

Please do. As far as I can remember, Al is always right.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
