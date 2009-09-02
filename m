From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 09:38:46 -0700
Message-ID: <70318cbf0909020938k54f4de2fm699c0af0f1b515a0@mail.gmail.com>
References: <20090830153202.4dc5c58c@s6510>
	 <200909021353.17091.kdudka@redhat.com> <20090902152146.GA7881@feather>
	 <200909021823.36662.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:34589 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZIBQio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 12:38:44 -0400
Received: by vws33 with SMTP id 33so73484vws.33
        for <linux-sparse@vger.kernel.org>; Wed, 02 Sep 2009 09:38:47 -0700 (PDT)
In-Reply-To: <200909021823.36662.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Wed, Sep 2, 2009 at 9:23 AM, Kamil Dudka<kdudka@redhat.com> wrote:
>
> No problem I think. We have generally two choices:
>
> =A0 =A01) The whole current test-enum.c as a test-case running with a=
ll three
> =A0 =A0 =A0 warnings enabled.
>
> =A0 =A02) Split the test to three parts, each for one separate -W opt=
ion, and
> =A0 =A0 =A0 then run it as three separate test-cases.

I like option 2) better. Having three test file.

I am playing with your patch right now. I will send out some feed back
soon. Over all I like the patch.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
