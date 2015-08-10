From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 2/3 v2] Handle all enum members in case statements
Date: Mon, 10 Aug 2015 07:16:36 -0400
Message-ID: <55C88814.2030604@redhat.com>
References: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
 <1438689994-30940-1-git-send-email-tcamuso@redhat.com>
 <CANeU7Qk7Xvs6RQuzDxq-9BrqCg-6VXnDUxmgwkREpWVX4Y2ynQ@mail.gmail.com>
 <55C1502E.5050609@redhat.com>
 <CANeU7Q=QAtRqDP36k8uOd9_XgzqjJ0du5SO2WpMEcjp8+mg3CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273AbbHJLQh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Aug 2015 07:16:37 -0400
In-Reply-To: <CANeU7Q=QAtRqDP36k8uOd9_XgzqjJ0du5SO2WpMEcjp8+mg3CQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On 08/07/2015 11:47 PM, Christopher Li wrote:
>
>
> On Tue, Aug 4, 2015 at 7:52 PM, Tony Camuso <tcamuso@redhat.com <mailto:tcamuso@redhat.com>> wrote:
>  >
>  > It was mentioned to me that the new prevailing wisdom is to "Prefer
>  > compile time errors to runtime errors", such that each enum'd value
>  > of a switch variable should be explicitly handled.
>
> Most of the code I saw, when using fail through, has comment emphasizing
> the fall through behavior.
>
>
>  > Or, if you prefer, I can resubmit the original patch with a linefeed after
>  > the "default:" for good form. Either way, I believe the compiler optimize
>  > them the same.
>
> Yes, I prefer the patch without have to list every enum member just to
> skip them.
>
>  > The whole reason for explicitly listing the existing enum members is so
>  > that new cases for which "break" may not be the correct solution can be
>  > easily identified at compile time.
>
> I can see that. However it only works for the switch statement that does
> not have the default handler already. In the field a lot of the switch statements
> already have default handler, depending on the compiler to give warning is
> not that reliable. Unless we ban the default handler all together.
>
> Chris
>

Thanks Chris,

I will resubmit the original patch with your recommendation for a newline
after the default: case.

Regards,
Tony
