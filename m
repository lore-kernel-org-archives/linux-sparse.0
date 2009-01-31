From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: source code transform
Date: Sat, 31 Jan 2009 15:37:53 -0800
Message-ID: <4984E0D1.6000004@zytor.com>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>	<1231354996.3545.80.camel@johannes> <87skntqs5e.fsf@aryx.cs.uiuc.edu>	<1231461536.5715.31.camel@brick> <87k594quiv.fsf@aryx.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41399 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZAaXib (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2009 18:38:31 -0500
In-Reply-To: <87k594quiv.fsf@aryx.cs.uiuc.edu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yoann Padioleau <padator@wanadoo.fr>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, mosfet <forumer@smartmobili.com>, linux-sparse@vger.kernel.org

Yoann Padioleau wrote:
>>>
>> Personal pet-peeve, use __func__, not __FUNCTION__.
>>
>> __func__ is C, __FUNCTION__ is a gcc-extension.
> 
> Ok. Is there also a __file__, and __line__ ? If this
> not the case then I would rather keep my __FUNCTION__, 
> it's estetically more consistent.
>

No, it's not.  __FILE__ and __LINE__ are macros (handled by the
preprocessor), but __func__ is a compiler token.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

