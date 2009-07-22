From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in switch"
	warnings
Date: Tue, 21 Jul 2009 17:29:51 -0700
Message-ID: <70318cbf0907211729j51e48ca0p430d898a5cb86bc8@mail.gmail.com>
References: <4A62338A.1060600@ramsay1.demon.co.uk>
	 <20090719140125.GA25417@feather>
	 <4A663005.5090009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:61736 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbZGVA3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 20:29:51 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1436129qwh.37
        for <linux-sparse@vger.kernel.org>; Tue, 21 Jul 2009 17:29:51 -0700 (PDT)
In-Reply-To: <4A663005.5090009@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 21, 2009 at 2:15 PM, Ramsay Jones<ramsay@ramsay1.demon.co.u=
k> wrote:

>> I don't think you want to add defaults like this just to avoid warni=
ngs.
>> Warnings like that can help when adding a new item to an enum, to fi=
nd
>> the places where you need to extend the code to hand the new item. =A0=
And
>> since current GCC doesn't even issue the warning by default, it seem=
s
>> even more unnecessary to add that default case.
>>
>
> OK...
>
> So, if I understand your argument, in order to make the best use of t=
hese
> warnings, then the correct change would look like the diff given belo=
w,
> and (for more up-to-date gcc) add -Wswitch-enum to CFLAGS (at least
> occasionally).

OK. I don't want to list all the enumerate value here just for the
sake of gcc warnings.
It makes the code ugly. Nor do I want to change the gcc flags used to c=
ompile
sparse. If the newest gcc still complain on those. I would rather add
the blank default
to make it clean. Since latest gcc doesn't issue warning on those. I
think it is fine to
leave it as it is.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
