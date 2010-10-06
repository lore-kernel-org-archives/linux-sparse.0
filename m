From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 01:40:09 -0700
Message-ID: <AANLkTim=hG4BQ2fxy-_LKR1z-NZOqJYffaOJw+0yJvYK@mail.gmail.com>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
	<201010052134.42915.vapier@gentoo.org>
	<AANLkTi=_MVVqr_hBx9GbhB5pmJWznakp8bmUXggfZAOi@mail.gmail.com>
	<201010060138.04508.vapier@gentoo.org>
	<20101006071018.GB2320@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50483 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0JFIkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 04:40:10 -0400
Received: by iwn5 with SMTP id 5so9464100iwn.19
        for <linux-sparse@vger.kernel.org>; Wed, 06 Oct 2010 01:40:09 -0700 (PDT)
In-Reply-To: <20101006071018.GB2320@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Wed, Oct 6, 2010 at 12:10 AM, Josh Triplett <josh@joshtriplett.org> =
wrote:
>> > Can we have some "ifdef" for the blackfin architecture in the pre =
buffer?
>> > I agree with Josh, that do look like very much blackfin specific. =
We can
>> > leave the ignore attribute alone for now.
>>
>> how would #ifdefs help ? =A0i'm not building sparse for a Blackfin a=
rch, host or
>> target wise. =A0if there's something more, you'd have to be specific=
 as to what
>> you mean, otherwise i wont be able to send an updated patch.
>
> I suspect that Chris meant that you could add_pre_buffer an #ifdef an=
d
> #endif surrounding the #define, so that the #define would only take
> effect if Sparse (or the command-line options passed by cgcc or Linux=
)
> defined some appropriate architecture-specific symbol for Blackfin.

Thanks for the clarification. The pre buffer is just a build in piece o=
f the
header file. You can still use #ifdef inside the pre buffer. I just don=
't want
 those blackfin specific declare show up in every other platform

>> yes, these things are completely Blackfin specific, but i dont see h=
ow that's
>> a barrier for entry when both attributes and the builtin ignore list=
s contain
>> completely architecture specific stuff without any #ifdef logic. =A0=
using sparse
>> on the Linux kernel for the Blackfin port is pretty useless atm beca=
use of
>> these missing pieces.

No, I don't mean that is a deal breaker. That is some thing nice to hav=
e.
Do you know any typical architecture defined symbol to identify the bla=
ckfin
port? Some thing similar to __x86_64__. How does gcc know it is compili=
ng
for a Blackfin port?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
