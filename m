From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Wed, 31 Aug 2011 15:09:40 +0300
Message-ID: <CAOJsxLEf=G90sveWrrmsx1nXFXi+pvPvjHBy=D6WC85sDz7F7g@mail.gmail.com>
References: <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
	<CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
	<alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
	<4E58731A.7010708@garzik.org>
	<alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
	<4E58AE9E.1090601@garzik.org>
	<4E59478C.9000504@garzik.org>
	<alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
	<4E5A129F.1090801@garzik.org>
	<CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
	<20110828175255.GA10203@leaf>
	<CA+55aFxm9vB8mFFy7y4pctyOeOE=8CjYUvL1mDdOnp2CihPd9w@mail.gmail.com>
	<4E5A980E.70308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44591 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1HaMJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Aug 2011 08:09:41 -0400
Received: by iabu26 with SMTP id u26so704261iab.19
        for <linux-sparse@vger.kernel.org>; Wed, 31 Aug 2011 05:09:40 -0700 (PDT)
In-Reply-To: <4E5A980E.70308@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 08/28/2011 02:23 PM, Linus Torvalds wrote:
>> On Sun, Aug 28, 2011 at 10:52 AM, Josh Triplett<josh@joshtriplett.or=
g>
>> =A0wrote:
>>>>
>>>> You should consider all types to be just "blocks of memory", and
>>>> sparse has already calculated all offsets etc for you. As far as L=
LVM
>>>> is concerned, the memory has no structure, it's just a blob.
>>>
>>> I suspect LLVM's optimization passes won't particularly care for th=
at
>>> approach.
>>
>> That's fine. We've already done the CSE and alias analysis on the
>> thing. And as mentioned, trying to turn overlapping (or partial)
>> accesses into some "named accesses" is just *wrong*. They weren't
>> named in the C code either. They are accesses through pointer
>> arithmetic. Trying to make them be somehow named would just be crazy=
=2E

On Sun, Aug 28, 2011 at 10:33 PM, Jeff Garzik <jeff@garzik.org> wrote:
> LLVM just cares about layout.
>
> It does not care about naming (or lack thereof). =A0Nobody/nothing is=
 trying
> to make them named.

Yup. The LLVM backend pretty much expects to know about struct layout.
=46or example, this simple initialization:

  struct symbol {
    char *s;
  };

  extern struct symbol foo;

  struct symbol *foo_p =3D &foo;

Looks like this in LLVM bitcode:

  %struct.symbol =3D type { i8* }

  @foo =3D external global %struct.symbol
  @foo_p =3D global %struct.symbol* @foo, align 8

I'm sure we *could* turn treat 'foo' as simple block of memory and
turn 'foo_p' into an untyped pointer. However, it's likely to be more
difficult than to just let LLVM know about struct layouts.

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
