From: Christopher Li <sparse@chrisli.org>
Subject: Re: segfault in sparse snapshot 2010-02-13
Date: Thu, 25 Mar 2010 10:20:30 -0700
Message-ID: <70318cbf1003251020j11ad7dd9m5e22b52699265526@mail.gmail.com>
References: <20100324104144.0817c22b.rdunlap@xenotime.net>
	 <20100324193622.GC4331@feather> <4BAA6C4C.8010103@xenotime.net>
	 <20100324203427.GA3015@feather> <20100325104947.GC5069@bicker>
	 <20100325154614.GD30147@feather> <4BAB8F36.2090600@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33906 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab0CYRUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Mar 2010 13:20:31 -0400
Received: by vws8 with SMTP id 8so915859vws.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Mar 2010 10:20:30 -0700 (PDT)
In-Reply-To: <4BAB8F36.2090600@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <error27@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Mar 25, 2010 at 9:28 AM, Randy Dunlap <rdunlap@xenotime.net> wr=
ote:
>
> OK, I emailed that file, but it's huge -- it probably won't be on the
> mailing list, so I also uploaded it to here:
> =A0http://www.xenotime.net/linux/doc/br_fdb.i

Thanks, I can duplicate the segfault now.

Looking at it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
