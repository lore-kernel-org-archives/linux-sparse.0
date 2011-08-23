From: Christopher Li <sparse@chrisli.org>
Subject: Re: bad asm goto ?
Date: Tue, 23 Aug 2011 14:55:58 -0700
Message-ID: <CANeU7QkFrvRMjAo4m11tEhi9QMVjqu_bnNEHMkzbh_zKSvzWmQ@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
	<AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
	<AANLkTik3OLbW=sM1PFi8uazBHiJbPD06d0ns2z0DQzzN@mail.gmail.com>
	<CAHLZz10y6-bxMRv=aJhza9EqT92gp=72f_w+7WopAL7GqPDP3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41808 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1HWVz6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Aug 2011 17:55:58 -0400
Received: by qyk38 with SMTP id 38so2322475qyk.19
        for <linux-sparse@vger.kernel.org>; Tue, 23 Aug 2011 14:55:58 -0700 (PDT)
In-Reply-To: <CAHLZz10y6-bxMRv=aJhza9EqT92gp=72f_w+7WopAL7GqPDP3A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

On Sun, Aug 21, 2011 at 9:01 PM, Harvey Harrison
<harvey.harrison@gmail.com> wrote:
> Ping, noticed you moving towards a 0.4.4 release and this was still not applied.

It falls through the cracks. I just add a test case and commit the fix.

Thanks for the reminder.

Chris
