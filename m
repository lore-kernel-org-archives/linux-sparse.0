From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] compiler/gcc5: Remove quirk for asm_volatile_goto()
Date: Tue, 14 Apr 2015 10:58:52 -0700
Message-ID: <CA+55aFzcyHJfP95EDZxOL7iCXg3HL42XqnMFoHFOSMhyGaKtMg@mail.gmail.com>
References: <552CDCF0.3050401@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34151 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbDNR6w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Apr 2015 13:58:52 -0400
Received: by iget9 with SMTP id t9so80413545ige.1
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2015 10:58:52 -0700 (PDT)
In-Reply-To: <552CDCF0.3050401@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>

On Tue, Apr 14, 2015 at 2:25 AM, Martin Li=C5=A1ka <mliska@suse.cz> wro=
te:
> Remove comments related to GCC 4.x branch and workaround for
> asm_volatile_goto which is fixed in GCC 5 release.

How sure are you that it is *really* fixed? Because it wasn't, last we =
saw.

It was originally claimed to be fixed in 4.8.2, but that turned out to
be wrong. See commit 5631b8fba640 ("compiler/gcc4+: Remove inaccurate
comment about 'asm goto' miscompiles"), and

    https://lkml.org/lkml/2014/2/12/817

which shows that the bugzilla you reference is at the very least
unreliable. Apparently the gcc test-case didn't catch all the
problems.

IOW, just leave the workaround. It has no actual cost, and the gcc bug
wasn't obviously fully fixed. There are apparently very few users of
"asm goto" (probably partly because of the limitations of it,
particularly the "no outputs").

                           Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
