From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 14:14:07 -0700
Message-ID: <AANLkTimp_cB4VgNH81xgDZ1ZGDLr_OhDse8LAUQMzdKB@mail.gmail.com>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
	<201010060138.04508.vapier@gentoo.org>
	<20101006071018.GB2320@feather>
	<201010061232.51680.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34240 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933101Ab0JFVOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 17:14:08 -0400
Received: by yxp4 with SMTP id 4so5040yxp.19
        for <linux-sparse@vger.kernel.org>; Wed, 06 Oct 2010 14:14:07 -0700 (PDT)
In-Reply-To: <201010061232.51680.vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Wed, Oct 6, 2010 at 9:32 AM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
> i guess sparse doesnt automatically propogate defines that gcc uses, =
so i'd
> have to add "-D__bfin__" to CHECKFLAGS in arch/blackfin/Makefile. =A0=
but that is
> what people are expecting, right ?

Right.  Same for __x86_64__, you need to tell sparse about it. I think
in the future
sparse should take the architecture arguments and define it automatical=
ly.
In other words, we should move some of the cgcc logic into sparse. But =
that
is for later change.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
