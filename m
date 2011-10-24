From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH 2/2] sparse: Use native sizes for data types
Date: Mon, 24 Oct 2011 10:06:15 +0300
Message-ID: <CAOJsxLEg+jSZGs=2_Try5yUOpip6zfLAvzqXHXhoon7Mt0JqHQ@mail.gmail.com>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
	<1319373420-8967-2-git-send-email-penberg@cs.helsinki.fi>
	<4EA4385C.1050800@garzik.org>
	<20111023171324.GA2940@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55494 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1JXHGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 03:06:17 -0400
Received: by vcge1 with SMTP id e1so4559845vcg.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 00:06:16 -0700 (PDT)
In-Reply-To: <20111023171324.GA2940@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Oct 23, 2011 at 8:13 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> On Sun, Oct 23, 2011 at 11:53:00AM -0400, Jeff Garzik wrote:
>> On 10/23/2011 08:37 AM, penberg@cs.helsinki.fi wrote:
>> >From: Pekka Enberg<penberg@kernel.org>
>> >
>> >This patch is needed to fix the sparsec LLVM backend data type size=
s.
>> >
>> >Cc: Christopher Li<sparse@chrisli.org>
>> >Cc: Jeff Garzik<jgarzik@redhat.com>
>> >Cc: Linus Torvalds<torvalds@linux-foundation.org>
>> >Signed-off-by: Pekka Enberg<penberg@kernel.org>
>> >---
>> > =A0target.c | =A0 10 +++++-----
>> > =A01 files changed, 5 insertions(+), 5 deletions(-)
>> >
>> >diff --git a/target.c b/target.c
>> >index 6a535bc..009002f 100644
>> >--- a/target.c
>> >+++ b/target.c
>> >@@ -17,9 +17,9 @@ int max_alignment =3D 16;
>> > =A0int bits_in_bool =3D 8;
>> > =A0int bits_in_char =3D 8;
>> > =A0int bits_in_short =3D 16;
>> >-int bits_in_int =3D 32;
>> >-int bits_in_long =3D 32;
>> >-int bits_in_longlong =3D 64;
>> >+int bits_in_int =3D sizeof(int) * 8;
>> >+int bits_in_long =3D sizeof(long) * 8;
>> >+int bits_in_longlong =3D sizeof(long long) * 8;
>> > =A0int bits_in_longlonglong =3D 128;
>> >
>> > =A0int max_int_alignment =3D 4;
>> >@@ -36,8 +36,8 @@ int max_fp_alignment =3D 8;
>> > =A0/*
>> > =A0 * Pointer data type
>> > =A0 */
>> >-int bits_in_pointer =3D 32;
>> >-int pointer_alignment =3D 4;
>> >+int bits_in_pointer =3D sizeof(void *) * 8;
>> >+int pointer_alignment =3D sizeof(void *);
>>
>> No objection, but ideally we should select from a target template.
>>
>> We don't want to start down the road of making runtime target
>> switching (i386/x86-64) difficult.
>
> Agreed. =A0The platform that sparse checks code for should not necess=
arily
> correlate with what sparse observes at compile-time about the build
> platform.

Sure, I'm happy to implement this in some other way if you have an
idea how to do it cleanly. My patches don't make runtime switching
harder and I think using native data type sizes for plain sparse is a
better default.

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
