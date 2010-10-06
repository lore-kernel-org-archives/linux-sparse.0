From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Tue, 5 Oct 2010 19:33:21 -0700
Message-ID: <AANLkTi=_MVVqr_hBx9GbhB5pmJWznakp8bmUXggfZAOi@mail.gmail.com>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
	<20101005161829.GB1859@feather>
	<201010052134.42915.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39231 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab0JFCdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Oct 2010 22:33:21 -0400
Received: by gxk9 with SMTP id 9so2266991gxk.19
        for <linux-sparse@vger.kernel.org>; Tue, 05 Oct 2010 19:33:21 -0700 (PDT)
In-Reply-To: <201010052134.42915.vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Tue, Oct 5, 2010 at 6:34 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> I wonder, does it make sense to support these kinds of
>> architecture-specific builtins on all architectures, rather than
>> limiting them based on some specified target architecture?
>>
>> Since Sparse doesn't generate code, it can easily target all
>> architectures simultaneously, but that doesn't mean we couldn't tell=
 it
>> what architecture to target. =A0Sparse could default to targeting th=
e
>> host architecture, which would avoid the need to pass extra flags in=
 the
>> common case.
>
> it does sound like it'd be useful to add an arch command line option.=
 =A0but i
> hoped we could sneak in the Blackfin stuff first since other arches (=
like
> alpha) have been whitelisted.

Can we have some "ifdef" for the blackfin architecture in the pre buffe=
r?
I agree with Josh, that do look like very much blackfin specific. We ca=
n leave
the ignore attribute alone for now.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
