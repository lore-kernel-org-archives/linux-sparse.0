From: Chris Li <christ.li@gmail.com>
Subject: Re: cgcc and REAL_CC help
Date: Sun, 20 Dec 2009 14:45:01 -0800
Message-ID: <70318cbf0912201445m37b31c71r6209a26b40892461@mail.gmail.com>
References: <4B29F6C2.7040800@scarlet.be>
	 <36ca99e90912170142p26b9b0aal1a08509d65c53047@mail.gmail.com>
	 <4B2BB887.6060508@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:3100 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbZLTWpC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 Dec 2009 17:45:02 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1205540eyd.19
        for <linux-sparse@vger.kernel.org>; Sun, 20 Dec 2009 14:45:01 -0800 (PST)
In-Reply-To: <4B2BB887.6060508@scarlet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: rubisher <rubisher@scarlet.be>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, linux-sparse@vger.kernel.org

On Fri, Dec 18, 2009 at 9:14 AM, rubisher <rubisher@scarlet.be> wrote:
> That said, my next issue is that "-E" which is disable by cgcc:
> [snip]
> =A0 =A0# If someone adds "-E", don't pre-process twice.
> =A0 =A0$do_compile =3D 0 if $_ eq '-E';
> [snip]
>
> If ever some of you knows why, I would be interested in?

My guess is that, both gcc and sparse pre-process print to stdout.
So allow them both pre-process will mess up the result.

The current cgcc chose to let sparse do the pre-process and don't
run the real cc. You can make the gcc does the real pro-process and
sparse just check though.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
