From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 11:29:47 -0700
Message-ID: <CANeU7Qmq+VMxPeRfY9wt9Jxb1NLHdWGAFONDpnk2th8Asqc4kQ@mail.gmail.com>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
	<CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
	<1332493309.2882.6.camel@pasglop>
	<CANeU7Qnd23X+jpM6Byx12igAugv=-EyQ1hN8DtG4N32y1yp7pQ@mail.gmail.com>
	<CANeU7QkzM-ZLZ_NgstAjpZdSe-eSgj+-SxEqUX-g5kXBTHrCvg@mail.gmail.com>
	<20120323180320.GA17003@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36828 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab2CWS3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 14:29:49 -0400
Received: by wejx9 with SMTP id x9so2864646wej.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 11:29:48 -0700 (PDT)
In-Reply-To: <20120323180320.GA17003@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Fri, Mar 23, 2012 at 11:03 AM, Josh Triplett <josh@joshtriplett.org>=
 wrote:
> On Fri, Mar 23, 2012 at 03:03:51AM -0700, Christopher Li wrote:
>> --- a/lib.c
>> +++ b/lib.c
>> @@ -224,6 +224,15 @@ static enum { STANDARD_C89,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0STANDARD_GNU89,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0STANDARD_GNU99, } standard =3D STANDA=
RD_GNU89;
>>
>> +#ifdef __x86_64__
>> +#define ARCH_M64_DEFAULT 1
>> +#else
>> +#define ARCH_M64_DEFAULT 0
>> +#endif
>
> Ideally this should work on other 64-bit architectures as well.


Thanks for the review.

I totally agree.  In the case it did not get it right,
it is not worse than existing code so that is not too bad.
I don't have other 64bit platform to test with though so
I am afraid to change some thing I can't test.

It would be a nice to have follow up patch adding different architectur=
e
handling using the handle_arch_finalize(). As it is, it will
still be wrong if you use sparse as a cross compiler.
We need proper arch handling for that.

Patch are definitely welcome.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
