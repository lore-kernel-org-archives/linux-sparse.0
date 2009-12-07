From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: sparse 0.4.2: cgcc issue
Date: Mon, 7 Dec 2009 20:04:42 +0200
Message-ID: <f43fc5580912071004r1df4949p5ce0003017b82d5b@mail.gmail.com>
References: <4B1AE007.8000509@scarlet.be> <4B1B9D2A.6080804@scarlet.be>
	<70318cbf0912070110ic52222xbb7c7be5829129f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:38500 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbZLGSE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Dec 2009 13:04:57 -0500
Received: by gxk26 with SMTP id 26so4337948gxk.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Dec 2009 10:05:03 -0800 (PST)
In-Reply-To: <70318cbf0912070110ic52222xbb7c7be5829129f9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: rubisher <rubisher@scarlet.be>, linux-sparse@vger.kernel.org

On Mon, Dec 7, 2009 at 11:10 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> On Sun, Dec 6, 2009 at 4:01 AM, rubisher <rubisher@scarlet.be> wrote:
>> mmm, I figure out that's because the number of args to call this rou=
tine
>> integer_types() should be the same as the number of =C2=A0@types's e=
lements (i.e.
>> 6) which is not allways the case:
>> e.g.
>> =C2=A0252 =C2=A0 =C2=A0 } elsif ($spec eq 'i86') {
>> 253 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (' -Di386=3D1 -D__i386=3D1 -D=
__i386__=3D1' .
>> 254 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &integer=
_types (8, 16, 32, $m64 ? 64 : 32, 64) .
>> 255 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &float_t=
ypes (1, 1, 21, [24,8], [53,11], [64,15]) .
>> 256 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &define_=
size_t ($m64 ? "long unsigned int" : "unsigned
>> int"));
>> 257 =C2=A0 =C2=A0 } elsif ($spec eq 'sparc') {
>> 258 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (' -Dsparc=3D1 -D__sparc=3D1 =
-D__sparc__=3D1' .
>> 259 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &integer=
_types (8, 16, 32, $m64 ? 64 : 32, 64) .
>> 260 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &float_t=
ypes (1, 1, 33, [24,8], [53,11], [113,15]) .
>> 261 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &define_=
size_t ($m64 ? "long unsigned int" : "unsigned
>> int"));
>> 262 =C2=A0 =C2=A0 } elsif ($spec eq 'sparc64') {
>> 263 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (' -Dsparc=3D1 -D__sparc=3D1 =
-D__sparc__=3D1 -D__sparcv9__=3D1
>> -D__sparc64__=3D1 -D__arch64__=3D1 -D__LP64__=3D1' .
>> 264 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &integer=
_types (8, 16, 32, 64, 64, 128) .
>> 265 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &float_t=
ypes (1, 1, 33, [24,8], [53,11], [113,15]) .
>
> Seems relate to Blue Swirl's 128 bit changes. Add to the CC list.

My Perl skills are not very bright, but the suggested patch
(http://marc.info/?l=3Dlinux-sparse&m=3D126010091922942&w=3D2) looks
correct.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
