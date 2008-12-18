From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH 2/15 v2] Unhardcode byte size being 8 bits.
Date: Thu, 18 Dec 2008 13:05:45 +0000
Message-ID: <494A4AA9.1060707@knosof.co.uk>
References: <20081217190534.24084.94887.stgit@zaytsev.su>	 <49498C67.4000700@cowlark.com>	 <f19298770812171633w43707eb0h8c0a0be262549ddf@mail.gmail.com>	 <4949A306.2060200@knosof.co.uk> <4949ACDF.50209@knosof.co.uk> <f19298770812171911u1e7e3cc0i11d33544cd519fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:61107 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbYLRNFz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 08:05:55 -0500
In-Reply-To: <f19298770812171911u1e7e3cc0i11d33544cd519fea@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

Alexey,

>> "This is a GCC extension. sizeof(void) is invalid C and should error out
>> and does with -pedantic-errors"
>>
>> Yuk, who ever thought to use -pedantic-errors!
>>
>> -ansi or -std=c89 or -std=c99 don't elicit any diagnostics.
> 
> I don't really see why you take this as a tragedy. People seem
> to like this extension:

I appreciate the reason for wanting to make this extension to
be friendly to people wanting to migrate pre-C standard code
and start using void.

There is plenty of opportunity for all sorts of subtle bugs here
and I would have hoped that gcc was more proactive in warning
users.  If people writing new code want a pointer to behave like
a char * then why not declare the fact.

Of course sparse has to support this usage, but I would expect it
to flag any usage as an error.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
