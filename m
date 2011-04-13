From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse, gcc 4.6 and a few build changes
Date: Wed, 13 Apr 2011 01:53:59 -0700
Message-ID: <BANLkTinOwWW0T6D+oFiNakXrc8SbpgqcpQ@mail.gmail.com>
References: <1302226355.2407.7.camel@raven.home.flameeyes.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51435 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab1DMIyA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 04:54:00 -0400
Received: by vws1 with SMTP id 1so274792vws.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 01:53:59 -0700 (PDT)
In-Reply-To: <1302226355.2407.7.camel@raven.home.flameeyes.eu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Diego_Elio_Petten=F2?= <flameeyes@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Diego,


The series looks good except the CFLAGS over ride change.

The CFLAGS obvious have two parts. Some of it can be savely
overwrite. Some of shouldn't be overwrite otherwise sparse can't
compile correctly.

I think it'd better seperate out the overwrite part of CFLAGS with
the rest of CFLAGS, just like the git makefile.

Some thing like the patch I attached. You might need to make some
changes to merge with your branch.

Can you rebase your series on the sparse chrisl branch?
http://git.kernel.org/?p=3Ddevel/sparse/chrisl/sparse.git;a=3Dsummary

Thanks

Chris


On Thu, Apr 7, 2011 at 6:32 PM, Diego Elio Petten=F2 <flameeyes@gmail.c=
om> wrote:
> Hello Christopher,
>
> I'm a Gentoo developer and I went to look at sparse today since it
> failed to build with the new GCC 4.6 version. I've fixed the build
> issue, but since I was looking at it I also made a number of changes
> that makes it much easier to build in Gentoo.
>
> If you could look at the patches and merge those that makes sense, it=
'd
> be lovely:
>
> http://git.overlays.gentoo.org/gitweb/?p=3Dproj/sparse.git;a=3Dsummar=
y
>
> Thanks in advance,
> --
> Diego Elio Petten=F2 =97 Flameeyes
> http://blog.flameeyes.eu/
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
