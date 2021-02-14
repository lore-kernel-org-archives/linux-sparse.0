Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1785AC433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC1E64DFF
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNSlB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 14 Feb 2021 13:41:01 -0500
Received: from avasout02.plus.net ([212.159.14.17]:34833 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNSlA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Feb 2021 13:41:00 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2021 13:40:59 EST
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id BMAmlWt0bjOtyBMAnlyiRA; Sun, 14 Feb 2021 18:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1613327469; bh=yk6k3r3Lc+Q2xV1cJNES+LP60UeYdJigmbJYZoJliEY=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To;
        b=gfHBgn2nr6eEYv5XI4rK6jaxgHcWDd9bEM25jKV1mTY4aV5X1wJ4z/Pv4gZv2fT3g
         RFk77Mvut43UUrw8QTIHy//ULc9F0VzDe/aS9RArg+pU2vdsLz9dLgOqbINULFpjm7
         gdXZhjqnYklUGSxXYVv5kvPyuW6uCPA9cJPTRLEHuwQaVjtnqiJKpcqbIqP88cEqiA
         mGpBWk/2XtMmVD6Xln1vnp7VgSaXsz/Q7HnCro8uUR5Sc+CMSGxf2acmUnWThXbdGJ
         KjW0zd2d5uuiVJs4UT6EBKE6MecxXB+IRuHvjdusT/Od6ODj4+e8RfumgIWhC0LtG0
         lQ/tMyBXyFZag==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UcTKtJaN c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8 a=lYq4HjzFCrfmUBwGw_8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status
 register
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian> <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com>
Date:   Sun, 14 Feb 2021 18:31:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEE5ufXw+kJ92UNnX3AIS9iRpF55xeJYNjK0/nNmIXp1OXxEWHMq0GcGwptj+BhVcSItCFONvLTSE+dTVG+MNsSEBWVSFLQc9b4VnVPlKnkZi3ewuEnU
 VWBUQCD+5Q4gX+97D5LutejG71wTzKT1pBSuh89al+Gmc647M5LSKNHc/96/WSHoUlAL30vneFqwaw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


[trimmed CC: list]

On 14/02/2021 17:06, Guido Günther wrote:
[snip]
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>    drivers/usb/typec/tps6598x.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, drivers/usb/typec/tps6598x_trace.h):
>>>> drivers/usb/typec/./tps6598x_trace.h:157:1: sparse: sparse: too long token expansion
>>
> 
> I looked around but didn't find any hints how to fix this. Any pointers
> I missed (added the sparse list to cc:)?

This is a limitation of sparse; when using the 'stringize' pre-processor
operator #, the maximum size of the resulting string is about 8k (if I
remember correctly).

It just so happens that I have a WIP patch from 2011 hanging around to
fix this - I didn't submit the patch, since it was easier to change the
original source (so that it didn't need such a huge string!). ;-)

Also, it was a very 'quick-n-dirty' patch which could probably be somewhat
improved (and may not even apply to the current codebase*).

ATB,
Ramsay Jones

*) I just tried to apply the patch but, as expected, there are conflicts.


