From: Yoann Padioleau <padator@wanadoo.fr>
Subject: Re: source code transform
Date: Fri, 09 Jan 2009 11:06:00 -0600
Message-ID: <87k594quiv.fsf@aryx.cs.uiuc.edu>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
	<1231354996.3545.80.camel@johannes> <87skntqs5e.fsf@aryx.cs.uiuc.edu>
	<1231461536.5715.31.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from expredir4.cites.uiuc.edu ([128.174.5.187]:50501 "EHLO
	expredir4.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbZAIRKU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Jan 2009 12:10:20 -0500
In-Reply-To: <1231461536.5715.31.camel@brick> (Harvey Harrison's message of "Thu\, 08 Jan 2009 16\:38\:56 -0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Yoann Padioleau <padator@wanadoo.fr>, Johannes Berg <johannes@sipsolutions.net>, mosfet <forumer@smartmobili.com>, linux-sparse@vger.kernel.org

Harvey Harrison <harvey.harrison@gmail.com> writes:

> On Thu, 2009-01-08 at 17:45 -0600, Yoann Padioleau wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>
>> @@
>> identifier f;
>> @@
>> 
>>  f(...)
>>  { 
>> + fprintf(stderr, "%s: %s()\n", __FILE__, __FUNCTION__);
>>  ...
>>  }
>> 
>
> Personal pet-peeve, use __func__, not __FUNCTION__.
>
> __func__ is C, __FUNCTION__ is a gcc-extension.

Ok. Is there also a __file__, and __line__ ? If this
not the case then I would rather keep my __FUNCTION__, 
it's estetically more consistent.

>
> Cheers,
>
> Harvey
