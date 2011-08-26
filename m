From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 4/5] sparse, i386: Fix boolean bit size
Date: Fri, 26 Aug 2011 09:26:29 +0300
Message-ID: <CAOJsxLEfoSizTVvcNb0sTyXR1eE5-RksqRAm6s8i1WrNJ68-0g@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<1314021451-24808-4-git-send-email-penberg@kernel.org>
	<CANeU7QktGkA-u9x7FzDUosVjNfhYeNv0C9o0G9n=SmuivWeNpQ@mail.gmail.com>
	<CAOJsxLG6OFC6tBYQtHu7k_3bYKWeag0cGiogG4XYQM6tCUeTgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60961 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1HZG0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 02:26:30 -0400
Received: by gxk21 with SMTP id 21so2506766gxk.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 23:26:30 -0700 (PDT)
In-Reply-To: <CAOJsxLG6OFC6tBYQtHu7k_3bYKWeag0cGiogG4XYQM6tCUeTgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 26, 2011 at 8:28 AM, Pekka Enberg <penberg@kernel.org> wrot=
e:
> On Fri, Aug 26, 2011 at 6:59 AM, Christopher Li <sparse@chrisli.org> =
wrote:
>> On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg <penberg@kernel.org> w=
rote:
>>> The value of 'ctype->bit_size' is set to 1 for booleans which confu=
ses the i386
>>> backend:
>>>
>>> =A0./compile allocate.c
>>> =A0compile: compile-i386.c:1406: emit_binop: Assertion `0' failed.
>>> =A0Aborted
>>>
>>> Looking at the code, we assume that "bit_size / 8" gives a sane res=
ult on
>>> various places. This patch fixes the problem by bumping bit_size to=
 8 for
>>> booleans. This also makes sizeof(_Bool) return 1 which is consisten=
t with what
>>> GCC 4.4.3, for example, does.
>>>
>>> diff --git a/target.c b/target.c
>>> index 17b228a..6a535bc 100644
>>> --- a/target.c
>>> +++ b/target.c
>>> @@ -14,7 +14,7 @@ int max_alignment =3D 16;
>>> =A0/*
>>> =A0* Integer data types
>>> =A0*/
>>> -int bits_in_bool =3D 1;
>>> +int bits_in_bool =3D 8;
>>
>> I object this part. I consider the sizeof(_Bool) =3D=3D 1 as externa=
l behaviour.
>> But internally we should know that the real useful part of bool is i=
n just one
>> bit, not any bit of that =A01 byte storage.
>
> You missed the most important part of my reasoning: sparse code
> already expects "bit_size / 8" to return a non-zero number and it's
> not just compile-i386.c! So while I don't disagree with you that we
> should internally know that a bool is just one bit, I don't consider
> that to be relevant for this particular patch.

Oh, I see the same problem with sparse-llvm when generating code for OP=
_CAST.

This little C function:

  int sete(int x, int y)
  {
    return x =3D=3D y;
  }

is compiled by GCC to:

00000170 <setne>:
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 0c             	mov    0xc(%ebp),%eax
 176:	39 45 08             	cmp    %eax,0x8(%ebp)
 179:	5d                   	pop    %ebp
 17a:	0f 95 c0             	setne  %al
 17d:	0f b6 c0             	movzbl %al,%eax
 180:	c3                   	ret

Sparse-llvm compiles the code to this which seems wrong:

00000140 <sete>:
 140:	31 c9                	xor    %ecx,%ecx
 142:	8b 44 24 08          	mov    0x8(%esp),%eax
 146:	39 44 24 04          	cmp    %eax,0x4(%esp)
 14a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 14f:	0f 45 c1             	cmovne %ecx,%eax
 152:	c3                   	ret

However, if I bump up 'bits_in_bool' to 32:

diff --git a/target.c b/target.c
index 17b228a..2b83498 100644
--- a/target.c
+++ b/target.c
@@ -14,7 +14,7 @@ int max_alignment =3D 16;
 /*
  * Integer data types
  */
-int bits_in_bool =3D 1;
+int bits_in_bool =3D 32;
 int bits_in_char =3D 8;
 int bits_in_short =3D 16;
 int bits_in_int =3D 32;

I get this from sparse-llvm:

00000140 <sete>:
 140:	8b 44 24 08          	mov    0x8(%esp),%eax
 144:	39 44 24 04          	cmp    %eax,0x4(%esp)
 148:	0f 94 c0             	sete   %al
 14b:	c3                   	ret

I don't know sparse well enough to know what's the right thing to do
here. Linus, Jeff, Chris, someone, anyone, help!!!

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
