From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse 0.4.2: cgcc issue
Date: Mon, 7 Dec 2009 01:10:23 -0800
Message-ID: <70318cbf0912070110ic52222xbb7c7be5829129f9@mail.gmail.com>
References: <4B1AE007.8000509@scarlet.be> <4B1B9D2A.6080804@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36084 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759084AbZLGJKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Dec 2009 04:10:18 -0500
Received: by ewy19 with SMTP id 19so166493ewy.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Dec 2009 01:10:23 -0800 (PST)
In-Reply-To: <4B1B9D2A.6080804@scarlet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: rubisher <rubisher@scarlet.be>, Blue Swirl <blauwirbel@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Dec 6, 2009 at 4:01 AM, rubisher <rubisher@scarlet.be> wrote:
> mmm, I figure out that's because the number of args to call this rout=
ine
> integer_types() should be the same as the number of =A0@types's eleme=
nts (i.e.
> 6) which is not allways the case:
> e.g.
> =A0252 =A0 =A0 } elsif ($spec eq 'i86') {
> 253 =A0 =A0 =A0 =A0 return (' -Di386=3D1 -D__i386=3D1 -D__i386__=3D1'=
 .
> 254 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &integer_types (8, 16, 32, $m64 ?=
 64 : 32, 64) .
> 255 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &float_types (1, 1, 21, [24,8], [=
53,11], [64,15]) .
> 256 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &define_size_t ($m64 ? "long unsi=
gned int" : "unsigned
> int"));
> 257 =A0 =A0 } elsif ($spec eq 'sparc') {
> 258 =A0 =A0 =A0 =A0 return (' -Dsparc=3D1 -D__sparc=3D1 -D__sparc__=3D=
1' .
> 259 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &integer_types (8, 16, 32, $m64 ?=
 64 : 32, 64) .
> 260 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &float_types (1, 1, 33, [24,8], [=
53,11], [113,15]) .
> 261 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &define_size_t ($m64 ? "long unsi=
gned int" : "unsigned
> int"));
> 262 =A0 =A0 } elsif ($spec eq 'sparc64') {
> 263 =A0 =A0 =A0 =A0 return (' -Dsparc=3D1 -D__sparc=3D1 -D__sparc__=3D=
1 -D__sparcv9__=3D1
> -D__sparc64__=3D1 -D__arch64__=3D1 -D__LP64__=3D1' .
> 264 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &integer_types (8, 16, 32, 64, 64=
, 128) .
> 265 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &float_types (1, 1, 33, [24,8], [=
53,11], [113,15]) .

Seems relate to Blue Swirl's 128 bit changes. Add to the CC list.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
