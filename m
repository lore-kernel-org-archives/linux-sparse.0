From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: convert the condition of branch/select to bool
Date: Sun, 19 Aug 2012 20:02:33 +0300
Message-ID: <CAOJsxLEvgodTi0kPNLQPm5hwwVwZN_cQALWCWbWfvN0G0PzarA@mail.gmail.com>
References: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
	<50311947.7080700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41605 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2HSRCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 13:02:34 -0400
Received: by weyx8 with SMTP id x8so3467627wey.19
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 10:02:33 -0700 (PDT)
In-Reply-To: <50311947.7080700@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 19, 2012 at 7:50 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 08/19/2012 10:52 AM, Jonathan Neusch=E4fer wrote:
>>
>> LLVM expects the first argument of "br" and "select" to be of type i=
1,
>> so add an "icmp ne <srcty> %src, 0" for other types.
>>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Christopher Li <sparse@chrisli.org>
>> Cc: Jeff Garzik <jgarzik@redhat.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
>> ---
>>   sparse-llvm.c                 |   13 +++++++++++--
>>   validation/backend/int-cond.c |   30 +++++++++++++++++++++++++++++=
+
>>   2 files changed, 41 insertions(+), 2 deletions(-)
>>   create mode 100644 validation/backend/int-cond.c
>
>
> Nice -- and I wonder if this fixes the loop bug Pekka noted in privat=
e email
> on 2011/11/23?
>
> Pekka, do you mind if I forward your email to the list?

No, not at all. Feel free to forward it.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
